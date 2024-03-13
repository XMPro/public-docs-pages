import os
import requests
from bs4 import BeautifulSoup
import json

# Function to truncate title
def truncate_title(title, max_chars=20):
    return title[:max_chars]

# Function to convert title to filename format
def format_filename(title):
    return title.strip().replace("&", "").replace("/", "-").lower().replace(" ", "-")

# Function to save content to Markdown file
def save_to_md(title, content, url, folder_path):
    try:
        # Format the title to use as filename
        filename_title = format_filename(title)
        
        # Truncate the filename to a maximum of 20 characters
        truncated_title = truncate_title(filename_title)
        
        filename = os.path.join(folder_path, f"{truncated_title}.md")

        with open(filename, 'w', encoding='utf-8') as file:
            file.write(f"# {title}\n\n")
            file.write(f"URL: {url}\n\n")
            file.write(content)
        
        print(f"Content saved to {filename}")
        return {'title': title, 'filename': filename}
    except Exception as e:
        print(f"Error occurred while saving to file: {e}")

# Function to scrape content from each page
def scrape_page(url, folder_path):
    try:
        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}
        with requests.Session() as session:
            response = session.get(url, headers=headers)
            response.raise_for_status()  # Raise an exception for bad status codes
            soup = BeautifulSoup(response.text, 'html.parser')

            # Find the main content area
            main_content = soup.find('main', id='main', class_='')
            if main_content:
                page_title = soup.title.string.strip()[:20]  # Truncate title to a maximum of 20 characters

                # Ensure the title is not empty after truncation
                if page_title.strip():
                    filename = os.path.join(folder_path, f"{page_title}.md")
                else:
                    filename = os.path.join(folder_path, "Untitled.md")

                with open(filename, 'w', encoding='utf-8') as file:
                    # Write page title as main heading
                    file.write(f"# {page_title}\n\n")

                    # Write page URL in the specified format
                    file.write(f"URL: {url}\n\n")

                    # Find all text and image elements within the main content area
                    for element in main_content.find_all(["p", "h1", "h2", "h3", "h4", "img"]):
                        if element.name == "img":
                            prop = "src"
                            if "data-src" in element.attrs:
                                prop = "data-src"
                            w = element.get("width")
                            h = element.get("height")
                            file.write(f'<img src="{element[prop]}" width="{w}" height="{h}">\n\n')
                        else:
                            if element.name.startswith("h"):
                                heading_level = int(element.name[1])
                                file.write(f"{'#' * heading_level} {element.get_text().strip()}\n\n")
                            else:
                                file.write(f"{element.get_text().strip()}\n\n")
                print(f"Content saved to {filename}")
                return {'title': page_title, 'filename': filename}
            else:
                print("Main content area not found.")
    except requests.RequestException as e:
        print(f"Failed to retrieve content from {url}: {e}")
    except Exception as e:
        print(f"Error occurred while fetching content from {url}: {e}")
    return None

# Function to update or create README.md with hyperlinks to exported markdown files
def update_readme(folder_path, md_files, title):
    try:
        readme_file = os.path.join(folder_path, "README.md")
        with open(readme_file, 'w', encoding='utf-8') as file:
            file.write(f"# {title}\n\n")
            for md_file in md_files:
                file.write(f"* [{md_file['title']}]({md_file['filename']})\n")
        print(f"README.md updated with hyperlinks to exported markdown files.")
    except Exception as e:
        print(f"Error occurred while updating README.md: {e}")

# Main function
def main():
    # Load configuration from JSON file
    with open('scripts\XMPRO Website Scrape Scripts\scrape-xmpro-website-about-config.json') as json_file:
        config = json.load(json_file)

    # Extract folder path from config
    folder_path = config.get('folderPath')

    if folder_path:
        # Ensure the folder path exists, create if it doesn't
        os.makedirs(folder_path, exist_ok=True)

        # Define the URLs to scrape
        urls = [
            "https://xmpro.com/about/",
            "https://xmpro.com/partners/",
            "https://xmpro.com/press-room/"
        ]

        # Scrape and export content for each URL
        md_files = []
        for url in urls:
            md_file_info = scrape_page(url, folder_path)
            if md_file_info:
                md_files.append(md_file_info)

        # Update or create README.md with hyperlinks to exported markdown files
        if md_files:
            update_readme(folder_path, md_files, "About")
        else:
            print("No markdown files found to update README.md.")
    else:
        print("Folder path not found in config.")

if __name__ == "__main__":
    main()
