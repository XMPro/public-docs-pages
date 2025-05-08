# Update Main TOC Script
# This script updates the main toc.yml file to include nested items for all sections

# Define the path to the main toc.yml file
$mainTocPath = "../toc.yml"

# Read the current toc.yml content
$mainToc = Get-Content $mainTocPath -Raw

# Define the sections that need to be updated with nested items
$sections = @(
    @{
        Name = "Concepts"
        Path = "docs/concepts/"
        Items = @(
            @{ Name = "XMPro AI"; Href = "docs/concepts/xmpro-ai/" },
            @{ Name = "Data Stream"; Href = "docs/concepts/data-stream/" },
            @{ Name = "Collection and Stream Host"; Href = "docs/concepts/collection.md" },
            @{ Name = "Agent"; Href = "docs/concepts/agent/" },
            @{ Name = "Application"; Href = "docs/concepts/application/" },
            @{ Name = "Recommendation"; Href = "docs/concepts/recommendation/" },
            @{ Name = "Connector"; Href = "docs/concepts/connector.md" },
            @{ Name = "Landing Pages & Favorites"; Href = "docs/concepts/landing-pages.md" },
            @{ Name = "Version"; Href = "docs/concepts/version.md" },
            @{ Name = "Manage Access"; Href = "docs/concepts/manage-access.md" },
            @{ Name = "Category"; Href = "docs/concepts/category.md" },
            @{ Name = "Variable"; Href = "docs/concepts/variable.md" },
            @{ Name = "Insights"; Href = "docs/concepts/insights/" }
        )
    },
    @{
        Name = "How-Tos"
        Path = "docs/how-tos/"
        Items = @(
            @{ Name = "Data Streams"; Href = "docs/how-tos/data-streams/" },
            @{ Name = "Application"; Href = "docs/how-tos/apps/" },
            @{ Name = "Recommendations"; Href = "docs/how-tos/recommendations/" },
            @{ Name = "Connectors"; Href = "docs/how-tos/connectors/" },
            @{ Name = "Stream Host"; Href = "docs/how-tos/stream-host.md" },
            @{ Name = "Agents"; Href = "docs/how-tos/agents/" },
            @{ Name = "Manage Versions"; Href = "docs/how-tos/manage-versions.md" },
            @{ Name = "Manage Access"; Href = "docs/how-tos/manage-access.md" },
            @{ Name = "Manage Categories"; Href = "docs/how-tos/manage-categories.md" },
            @{ Name = "Manage Variables"; Href = "docs/how-tos/manage-variables.md" },
            @{ Name = "Import, Export, and Clone"; Href = "docs/how-tos/import-export-and-clone.md" },
            @{ Name = "Publish"; Href = "docs/how-tos/publish/" },
            @{ Name = "Manage Site Settings"; Href = "docs/how-tos/manage-site-settings.md" },
            @{ Name = "Manage Landing Pages & Favorites"; Href = "docs/how-tos/manage-landing-pages.md" }
        )
    },
    @{
        Name = "Blocks-Toolbox"
        Path = "docs/blocks-toolbox/"
        Items = @(
            @{ Name = "Common Properties"; Href = "docs/blocks-toolbox/common-properties.md" },
            @{ Name = "Layout"; Href = "docs/blocks-toolbox/layout/" },
            @{ Name = "Basic"; Href = "docs/blocks-toolbox/basic/" },
            @{ Name = "Device Input"; Href = "docs/blocks-toolbox/device-input/" },
            @{ Name = "AI"; Href = "docs/blocks-toolbox/ai/" },
            @{ Name = "Actions"; Href = "docs/blocks-toolbox/actions/" },
            @{ Name = "Recommendations"; Href = "docs/blocks-toolbox/recommendations/" },
            @{ Name = "Visualizations"; Href = "docs/blocks-toolbox/visualizations/" },
            @{ Name = "Advanced"; Href = "docs/blocks-toolbox/advanced/" },
            @{ Name = "Widgets"; Href = "docs/blocks-toolbox/widgets.md" }
        )
    },
    @{
        Name = "Administration"
        Path = "docs/administration/"
        Items = @(
            @{ Name = "Administrative Accounts"; Href = "docs/administration/administrative-accounts.md" },
            @{ Name = "Language"; Href = "docs/administration/language.md" },
            @{ Name = "Companies"; Href = "docs/administration/companies/" },
            @{ Name = "Subscriptions"; Href = "docs/administration/subscriptions-admin/" },
            @{ Name = "Users"; Href = "docs/administration/users/" }
        )
    },
    @{
        Name = "Installation"
        Path = "docs/installation/"
        Items = @(
            @{ Name = "Overview"; Href = "docs/installation/overview.md" },
            @{ Name = "1. Preparation"; Href = "docs/installation/install.md" },
            @{ Name = "2. Install XMPro"; Href = "docs/installation/2.-deployment/" },
            @{ Name = "3. Complete Installation"; Href = "docs/installation/3.-complete-installation/" }
        )
    },
    @{
        Name = "Release Notes"
        Path = "docs/release-notes/"
        Items = @(
            @{ Name = "v4.4.18"; Href = "docs/release-notes/v4.4.18.md" },
            @{ Name = "v4.4.17"; Href = "docs/release-notes/v4.4.17.md" },
            @{ Name = "v4.4.16"; Href = "docs/release-notes/v4.4.16.md" },
            @{ Name = "v4.4.15"; Href = "docs/release-notes/v4.4.15.md" },
            @{ Name = "v4.4.14"; Href = "docs/release-notes/v4.4.14.md" },
            @{ Name = "v4.4.13"; Href = "docs/release-notes/v4.4.13.md" },
            @{ Name = "v4.4.12"; Href = "docs/release-notes/v4.4.12.md" },
            @{ Name = "v4.4.11"; Href = "docs/release-notes/v4.4.11.md" },
            @{ Name = "v4.4.10"; Href = "docs/release-notes/v4.4.10.md" },
            @{ Name = "v4.4.9"; Href = "docs/release-notes/v4.4.9.md" },
            @{ Name = "v4.4.8"; Href = "docs/release-notes/v4.4.8.md" },
            @{ Name = "v4.4.7"; Href = "docs/release-notes/v4.4.7.md" },
            @{ Name = "v4.4.6"; Href = "docs/release-notes/v4.4.6.md" },
            @{ Name = "v4.4.5"; Href = "docs/release-notes/v4.4.5.md" },
            @{ Name = "v4.4.4"; Href = "docs/release-notes/v4.4.4.md" },
            @{ Name = "v4.4.3"; Href = "docs/release-notes/v4.4.3.md" },
            @{ Name = "v4.4.2"; Href = "docs/release-notes/v4.4.2.md" },
            @{ Name = "v4.4.1"; Href = "docs/release-notes/v4.4.1.md" },
            @{ Name = "v4.4.0"; Href = "docs/release-notes/v4.4.0.md" },
            @{ Name = "Archived"; Href = "docs/release-notes/archived/" }
        )
    },
    @{
        Name = "Resources"
        Path = "docs/resources/"
        Items = @(
            @{ Name = "What's New"; Href = "docs/resources/whats-new/" },
            @{ Name = "Integrations"; Href = "docs/resources/integrations.md" },
            @{ Name = "Sizing Guideline"; Href = "docs/resources/sizing-guideline.md" },
            @{ Name = "Platform Security"; Href = "docs/resources/platform-security.md" },
            @{ Name = "Icon Library"; Href = "docs/resources/icon-library.md" },
            @{ Name = "FAQs"; Href = "docs/resources/faqs/" },
            @{ Name = "Practice Notes"; Href = "docs/resources/practice-notes/" }
        )
    }
)

# Update the toc.yml content for each section
foreach ($section in $sections) {
    $sectionName = $section.Name
    $sectionPath = $section.Path
    $sectionItems = $section.Items
    
    # Create the YAML for the section items
    $itemsYaml = ""
    foreach ($item in $sectionItems) {
        $itemName = $item.Name
        $itemHref = $item.Href
        $itemsYaml += "  - name: $itemName`r`n    href: $itemHref`r`n"
    }
    
    # Create the pattern to search for
    $pattern = "- name: $sectionName`r?`n  href: $sectionPath"
    
    # Create the replacement
    $replacement = "- name: $sectionName`r`n  items:`r`n$itemsYaml"
    
    # Update the toc.yml content
    $mainToc = $mainToc -replace $pattern, $replacement
}

# Write the updated toc.yml content back to the file
Set-Content -Path $mainTocPath -Value $mainToc

Write-Host "Main toc.yml file updated successfully."
