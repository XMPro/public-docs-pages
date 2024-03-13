import os
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin  # Add this import statement
import re
import json
from time import sleep

def scrape_page(url):
    try:
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}
        with requests.Session() as session:
            response = session.get(url, headers=headers)
            response.raise_for_status()  # Raise an exception for bad status codes
            soup = BeautifulSoup(response.text, 'html.parser')

        # Remove unwanted elements
        for element in soup.find_all(['div', 'h6']):
            if element.get('class') == ['fill', 'banner-link'] or element.get('class') == ['entry-category', 'is-xsmall']:
                element.extract()

        # Get title
        title_tag = soup.find('title')
        if title_tag:
            title = title_tag.get_text().strip()
        else:
            title = "Untitled"

        # Truncate title if it's too long
        title = title[:20]

        # Get content including headings
        content = ""
        content_div = soup.find('div', class_='entry-content')
        if content_div:
            for element in content_div.find_all(['h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p']):
                if element.name.startswith('h'):
                    # Extract heading level
                    heading_level = int(element.name[1])
                    # Add appropriate number of '#' characters for heading level
                    content += '#' * heading_level + " " + element.get_text() + "\n\n"
                elif element.name == 'p':
                    # Add paragraph content
                    content += element.get_text() + "\n\n"

        return title, content
    except requests.RequestException as e:
        print(f"Failed to retrieve content from {url}: {e}")
        return None, None
    except Exception as e:
        print(f"Error occurred while fetching content from {url}: {e}")
        return None, None

def save_to_md(title, content, url, folder_path):
    try:
        # Truncate title for filename if it's too long
        filename = os.path.join(folder_path, f"{re.sub(r'[^\w\s]', '', title.strip().replace(' ', '_'))[:20]}.md")

        with open(filename, 'w', encoding='utf-8') as file:
            file.write(f"# {title}\n\n")
            file.write(f"URL: {url}\n\n")
            file.write(content)
        print(f"Content saved to {filename}")
    except Exception as e:
        print(f"Error occurred while saving to file: {e}")

def get_all_blog_urls(base_url, num_pages):
    all_blog_urls = set()  # Use a set to avoid duplicate URLs
    for page_num in range(1, num_pages+1):
        page_url = f"{base_url}page/{page_num}/"
        try:
            headers = {
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}
            with requests.Session() as session:
                response = session.get(page_url, headers=headers)
                response.raise_for_status()  # Raise an exception for bad status codes
                soup = BeautifulSoup(response.text, 'html.parser')
                # Find the div with class 'large-9 col'
                target_div = soup.find('div', class_='large-9 col')
                if target_div:
                    # Find all anchor tags within the target div
                    for link in target_div.find_all('a', href=True):
                        # Resolve relative URLs to absolute URLs
                        absolute_url = urljoin(base_url, link['href'])
                        all_blog_urls.add(absolute_url)
                else:
                    print(f"Could not find the target div on page {page_num}")
        except requests.RequestException as e:
            print(f"Failed to retrieve content for page {page_num}: {e}")
        except Exception as e:
            print(f"Error occurred: {e}")
        # Introduce a delay of 1 second between navigating to a new page
        sleep(1)
    return all_blog_urls

def get_max_page_numbers(html, base_url):
    soup = BeautifulSoup(html, 'html.parser')
    page_numbers = soup.find_all(class_='page-number')
    max_page = 1  # Default value if no page numbers are found
    for page_number in page_numbers:
        try:
            page = int(page_number.text)
            page_url = urljoin(base_url, page_number.get('href'))
            if page > max_page:
                max_page = page
        except ValueError:
            pass  # Ignore non-integer page numbers
    return max_page

# Load JSON configuration
with open('scripts\XMPRO Website Scrape Scripts\scrape-xmpro-website-blogs-config.json') as json_file:
    config_data = json.load(json_file)

# Retrieve folder path from JSON
folder_path = config_data.get('folderPath', 'docs/external content/Blogs')
os.makedirs(folder_path, exist_ok=True)

# Example HTML snippet
html_snippet = '''
<ul class="page-numbers nav-pagination links text-center">
    <li><span aria-current="page" class="page-number current">1</span></li>
    <li><a class="page-number" href="https://xmpro.com/category/blog/page/2/">2</a></li>
    <li><a class="page-number" href="https://xmpro.com/category/blog/page/3/">3</a></li>
    <li><a class="page-number" href="https://xmpro.com/category/blog/page/4/">4</a></li>
    <li><span class="page-number dots">…</span></li>
    <li><a class="page-number" href="https://xmpro.com/category/blog/page/6/">6</a></li>
    <li><a class="next page-number" href="https://xmpro.com/category/blog/page/2/"><i class="icon-angle-right"></i></a></li>
</ul>
'''

base_url = "https://xmpro.com/category/blog/"
num_pages = get_max_page_numbers(html_snippet, base_url)

all_blog_urls = get_all_blog_urls(base_url, num_pages)

for url in all_blog_urls:
    # Introduce a delay of 1 second before scraping each page
    sleep(1)
    title, content = scrape_page(url)
    if title and content:
        save_to_md(title, content, url, folder_path)  # Call save_to_md instead of save_to_txt
    else:
        print(f"Failed to scrape the page: {url}")
