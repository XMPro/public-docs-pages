# XMPro Documentation Migration Plan: GitBook to DocFX

This document outlines the plan for migrating the XMPro documentation from GitBook to DocFX. The migration will be done iteratively, with each step being completed and verified before moving on to the next step.

## Migration Progress Dashboard

| Section | Status | Progress | Notes |
|---------|--------|----------|-------|
| Project Structure | ✅ Complete | 100% | Basic DocFX structure set up |
| Navigation | ✅ Complete | 100% | Main TOC and section TOCs created |
| Introduction & Getting Started | ✅ Complete | 100% | All pages migrated |
| Concepts | ✅ Complete | 100% | All subsections and pages migrated |
| How-Tos | 🔄 In Progress | 90% | Most subsections migrated, some pages still pending |
| Blocks-Toolbox | ✅ Complete | 100% | All subsections and pages migrated |
| Administration | ⏳ Not Started | 0% | Planned for future sprint |
| Installation | ⏳ Not Started | 0% | Planned for future sprint |
| Release Notes | ⏳ Not Started | 0% | Planned for future sprint |
| Resources | ⏳ Not Started | 0% | Lowest priority section |
| Styling & Customization | 🔄 In Progress | 50% | Basic styling applied, further customization needed |
| Link Verification | ⏳ Not Started | 0% | To be done after all content is migrated |
| Final Review & Deployment | ⏳ Not Started | 0% | Final step |

**Legend:**
- ✅ Complete: Section fully migrated and verified
- 🔄 In Progress: Work has started on this section
- ⏳ Not Started: Work has not yet begun on this section

## Migration Overview

The migration will follow these high-level steps:

1. Set up the DocFX project structure
2. Migrate the navigation structure
3. Migrate core content pages
4. Migrate images and other assets
5. Implement styling and customization
6. Verify links and functionality
7. Deploy the migrated documentation

## Commit Strategy

Each step of the migration will be committed directly to the main branch of the public-docs-pages repository. This approach simplifies the workflow and ensures that changes are immediately available in the main branch.

**IMPORTANT:** Follow these steps for each migration task:

1. Make your changes
2. Add the changes to the staging area: `git add .`
3. Commit the changes: `git commit -m "Descriptive message about the changes"`
4. Push the changes to the remote repository: `git push origin main`

## Migration Steps

### Step 1: Set up the DocFX Project Structure ✅

**Status:** Complete

1. Create the basic DocFX project structure ✅
2. Configure docfx.json for the XMPro documentation ✅
3. Set up the initial toc.yml file ✅
4. Create placeholder files for key sections ✅
5. Verify the basic structure works by building and serving the site ✅

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that the basic structure is in place. Specifically:
1. Check that the main sections are visible in the navigation
2. Verify that placeholder pages load correctly
3. Ensure that the basic DocFX structure is functioning properly

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Set up DocFX project structure"
git push origin main
```

### Step 2: Migrate the Main Navigation Structure ✅

**Status:** Complete

1. Analyze the GitBook SUMMARY.md file to understand the current navigation structure ✅
2. Create the main toc.yml file in the DocFX project ✅
3. Create section toc.yml files for each major section ✅
4. Verify the navigation structure works correctly ✅

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that the navigation structure matches the GitBook structure. Specifically:
1. Check that all sections from the GitBook SUMMARY.md are present in the navigation
2. Verify that the hierarchy of pages matches the original structure
3. Ensure that navigation links work correctly
4. Test navigation between different sections and pages

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate main navigation structure"
git push origin main
```

### Step 3: Migrate the Introduction and Getting Started Sections ✅

**Status:** Complete

1. Migrate the README.md file to introduction.md ✅
2. Migrate the Getting Started section pages ✅
3. Update links and references in these pages ✅
4. Create necessary images directory and migrate images used in these pages ✅

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that the Introduction and Getting Started sections display correctly. For each migrated page:
1. Navigate to the page through the menu structure
2. Verify that the content displays correctly
3. Check that all links within the page work
4. Ensure that the page is accessible from the navigation menu

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate Introduction and Getting Started sections"
git push origin main
```

### Step 4: Migrate the Concepts Section ✅

**Status:** Complete

1. Create the concepts directory structure ✅
2. Migrate the Concepts section pages ✅
   - Core concept pages ✅
   - Agent subsection ✅
   - Data Stream subsection ✅
   - Application subsection ✅
   - Insights subsection ✅
   - Recommendation subsection ✅
   - XMPro AI subsection ✅
3. Update links and references in these pages ✅
4. Migrate images used in these pages ✅

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that the Concepts section displays correctly. For each migrated page:
1. Navigate to the page through the menu structure
2. Verify that the content displays correctly
3. Check that all links within the page work
4. Ensure that the page is accessible from the navigation menu

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate Concepts section"
git push origin main
```

### Step 5: Migrate the How-Tos Section 🔄

**Status:** In Progress (85%)

1. Create the how-tos directory structure ✅
2. Migrate the How-Tos section pages 🔄
   - Agents subsection 🔄 (In Progress)
   - Apps subsection ✅ (Complete - all files migrated and images updated)
   - Connectors subsection ⏳ (Not Started)
   - Data Streams subsection 🔄 (In Progress)
   - Publish subsection ⏳ (Not Started)
   - Recommendations subsection ⏳ (Not Started)
3. Update links and references in these pages 🔄
4. Migrate images used in these pages 🔄

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that the How-Tos section displays correctly. For each migrated page:
1. Navigate to the page through the menu structure
2. Verify that the content displays correctly
3. Check that all links within the page work
4. Ensure that the page is accessible from the navigation menu

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate How-Tos section"
git push origin main
```

### Step 6: Migrate the Blocks-Toolbox Section 🔄

**Status:** In Progress (43%)

1. Create the blocks-toolbox directory structure ✅
2. Migrate the Blocks-Toolbox section pages 🔄
   - Basic files (index.md, toc.yml, common-properties.md, widgets.md) ✅
   - Layout subsection ✅
   - Basic subsection ✅ (Complete - all files migrated)
   - Device-input subsection ✅ (Complete - all files migrated)
   - AI subsection ✅ (Complete - all files migrated)
   - Actions subsection ✅ (Complete - all files migrated)
   - Recommendations subsection ✅ (Complete - all files migrated)
   - All subsections ✅ (Complete - all files migrated)
3. Update links and references in these pages 🔄
4. Migrate images used in these pages 🔄

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that the Blocks-Toolbox section displays correctly. For each migrated page:
1. Navigate to the page through the menu structure
2. Verify that the content displays correctly
3. Check that all links within the page work
4. Ensure that the page is accessible from the navigation menu

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate Blocks-Toolbox section"
git push origin main
```

### Step 7: Migrate the Administration Section ⏳

**Status:** Not Started

1. Create the administration directory structure ⏳
2. Migrate the Administration section pages ⏳
3. Update links and references in these pages ⏳
4. Migrate images used in these pages ⏳

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that the Administration section displays correctly. For each migrated page:
1. Navigate to the page through the menu structure
2. Verify that the content displays correctly
3. Check that all links within the page work
4. Ensure that the page is accessible from the navigation menu

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate Administration section"
git push origin main
```

### Step 8: Migrate the Installation Section ⏳

**Status:** Not Started

1. Create the installation directory structure ⏳
2. Migrate the Installation section pages ⏳
3. Update links and references in these pages ⏳
4. Migrate images used in these pages ⏳

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that the Installation section displays correctly. For each migrated page:
1. Navigate to the page through the menu structure
2. Verify that the content displays correctly
3. Check that all links within the page work
4. Ensure that the page is accessible from the navigation menu

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate Installation section"
git push origin main
```

### Step 9: Migrate the Release Notes Section ⏳

**Status:** Not Started

1. Create the release-notes directory structure ⏳
2. Migrate the Release Notes section pages ⏳
3. Update links and references in these pages ⏳
4. Migrate images used in these pages ⏳

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that the Release Notes section displays correctly. For each migrated page:
1. Navigate to the page through the menu structure
2. Verify that the content displays correctly
3. Check that all links within the page work
4. Ensure that the page is accessible from the navigation menu

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate Release Notes section"
git push origin main
```

### Step 10: Migrate the Resources Section (Last Priority) ⏳

**Status:** Not Started

1. Create the resources directory structure ⏳
2. Migrate the Resources section pages ⏳
3. Update links and references in these pages ⏳
4. Migrate images used in these pages ⏳

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that the Resources section displays correctly. For each migrated page:
1. Navigate to the page through the menu structure
2. Verify that the content displays correctly
3. Check that all links within the page work
4. Ensure that the page is accessible from the navigation menu

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate Resources section"
git push origin main
```

### Step 11: Implement Styling and Customization 🔄

**Status:** In Progress (50%)

1. Customize the DocFX template to match XMPro branding ⏳
2. Implement custom CSS for styling ⏳
3. Configure the search functionality ⏳
4. Add custom JavaScript for enhanced functionality ⏳

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that the styling and customization match the desired look and feel. Specifically:
1. Check that the branding elements (logo, colors, fonts) match XMPro's style guide
2. Verify that the layout is consistent across different pages and sections
3. Test the responsiveness of the site on different screen sizes
4. Ensure that the search functionality works correctly

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Implement styling and customization"
git push origin main
```

### Step 12: Verify Links and Functionality ⏳

**Status:** Not Started

1. Check all internal links to ensure they work correctly ⏳
2. Verify external links are correct ⏳
3. Test search functionality ⏳
4. Test navigation functionality ⏳
5. Verify images and other assets display correctly ⏳

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that all links and functionality work correctly. Specifically:
1. Check all internal links by navigating through the site
2. Verify that external links open correctly in a new tab
3. Test the search functionality with various search terms
4. Verify that the navigation menu works correctly at all levels
5. Check that all images display correctly and have appropriate alt text
6. Test the site on different browsers and devices to ensure cross-browser compatibility

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Verify links and functionality"
git push origin main
```

### Step 13: Final Review and Deployment ⏳

**Status:** Not Started

1. Perform a final review of the migrated documentation ⏳
2. Fix any remaining issues ⏳
3. Verify the GitHub Actions workflow for automatic deployment ⏳
4. Ensure the final changes are pushed to the main branch to trigger deployment ⏳

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that the documentation is ready for deployment. Specifically:
1. Perform a comprehensive review of all sections and pages
2. Verify that all content has been migrated correctly
3. Check that all links, images, and functionality work as expected
4. Ensure that the styling and branding are consistent throughout the site
5. Test the site on different browsers and devices

After pushing to main, verify that the deployed documentation works correctly on GitHub Pages by:
1. Checking that the deployment workflow completed successfully
2. Verifying that the site is accessible at the correct URL
3. Testing key functionality on the live site
4. Ensuring that all content is displayed correctly

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Final review and deployment preparation"
git push origin main
```

## Weekly Migration Status Meetings

To ensure the migration stays on track, weekly status meetings will be held every Monday at 10:00 AM. These meetings will:

1. Review progress from the previous week
2. Identify any blockers or issues
3. Assign tasks for the upcoming week
4. Update the migration plan and timeline as needed

Meeting notes will be recorded and shared with the team.

## Continuous Deployment

A GitHub Actions workflow has been set up to automatically deploy the documentation to GitHub Pages whenever changes are pushed to the main branch. This ensures that each migration step is immediately visible on the public documentation site once it's completed.

The deployment workflow is defined in `.github/workflows/deploy-docs.yml` and performs the following steps:

1. Checks out the repository
2. Sets up .NET
3. Installs DocFX
4. Builds the DocFX documentation
5. Deploys the built site to the gh-pages branch

This means that after each migration step is completed and pushed to main, the changes will be automatically deployed to GitHub Pages. This allows for incremental deployment of the documentation as the migration progresses.

## Content Migration Guidelines

### Markdown Conversion

GitBook and DocFX both use Markdown, but there are some differences in syntax and features. Here are some guidelines for converting GitBook Markdown to DocFX Markdown:

1. **Hints/Callouts:** Convert GitBook hints to DocFX alerts:

   GitBook:
   ```markdown
   > [!NOTE]
   > This is a note
   ```

   DocFX:
   ```markdown
   > [!NOTE]
   > This is a note
   ```

2. **Tabs:** Convert GitBook tabs to DocFX tabs:

   GitBook:
   ```markdown
   {% tabs %}
   {% tab title="Tab 1" %}
   Content for Tab 1
   {% endtab %}
   {% tab title="Tab 2" %}
   Content for Tab 2
   {% endtab %}
   {% endtabs %}
   ```

   DocFX:
   ```markdown
   # [Tab 1](#tab/tab1)
   Content for Tab 1

   # [Tab 2](#tab/tab2)
   Content for Tab 2

   ***
   ```

3. **Code Blocks:** Ensure code blocks use the correct syntax:

   GitBook:
   ```markdown
   ```javascript
   const x = 5;
   ```
   ```

   DocFX:
   ```markdown
   ```javascript
   const x = 5;
   ```
   ```

4. **Images:** Update image paths to use the correct relative paths:

   GitBook:
   ```markdown
   ![Alt text](../assets/image.png)
   ```

   DocFX:
   ```markdown
   ![Alt text](../images/image.png)
   ```

5. **Links:** Update links to use the correct relative paths:

   GitBook:
   ```markdown
   [Link text](../path/to/page.md)
   ```

   DocFX:
   ```markdown
   [Link text](../path/to/page.md)
   ```

### Image Migration

1. Create an `images` directory in each section directory
2. Copy images from the GitBook `assets` directory to the appropriate `images` directory
3. Update image references in the Markdown files to use the new paths

### Link Updates

1. Update internal links to use the correct relative paths
2. Verify external links are correct
3. Update anchor links to use the correct format

## Migration Helper Script

A PowerShell script (`migration-helper.ps1`) has been created to assist with the migration process. This script helps with:

1. Creating the necessary directory structure
2. Converting GitBook Markdown to DocFX Markdown
3. Updating image and link references
4. Generating toc.yml files from the GitBook SUMMARY.md file

To use the migration helper script, see the instructions in [MIGRATION-README.md](MIGRATION-README.md).

## Handling DocFX Build Warnings

During the migration process, you will encounter various warnings when building the DocFX project. These warnings are normal and expected, especially during the early stages of migration when not all content has been migrated yet.

### Types of Warnings

The main types of warnings you will encounter are:

1. Missing directories referenced in toc.yml files
2. Invalid file links in markdown files
3. Missing files referenced in toc.yml files

### Handling Warnings

A detailed guide on handling DocFX build warnings is available in the [handling-docfx-warnings.md](handling-docfx-warnings.md) document. This document explains:

- Why these warnings occur
- How to handle these warnings during the migration process
- Strategies for addressing specific warning types
- Using the migration helper script to resolve warnings
- Final cleanup process to address remaining warnings

### Warning Resolution Strategy

The strategy for handling warnings during the migration process is:

1. **Ignore non-critical warnings during initial migration**: Focus on migrating content first, then address warnings
2. **Address warnings incrementally**: As you migrate each section, address the warnings related to that section
3. **Create placeholder files and directories**: For missing files and directories referenced in toc.yml files
4. **Migrate images early**: To resolve invalid image references
5. **Perform final cleanup**: Once all content is migrated, address any remaining warnings

By following this strategy, you can effectively manage and resolve warnings without getting bogged down in fixing every warning during the initial migration process.

## Conclusion

This migration plan provides a structured approach to migrating the XMPro documentation from GitBook to DocFX. By following this plan, the migration can be done in a systematic and controlled manner, ensuring that the migrated documentation is accurate, complete, and functional.

Each step should be completed and verified before moving on to the next step. This approach minimizes the risk of issues and ensures that the migration is done correctly.

Remember that warnings are a normal part of the migration process and should be addressed incrementally as you progress through the migration steps. Don't let warnings block your progress, but also don't ignore them completely.
