# XMPro Documentation Migration Plan: GitBook to DocFX

This document outlines the plan for migrating the XMPro documentation from GitBook to DocFX. The migration will be done iteratively, with each step being completed and verified before moving on to the next step.

## Migration Progress Dashboard

| Migration Phase | Status | Progress | Estimated Completion |
|-----------------|--------|----------|----------------------|
| 1. Project Setup | ✅ Completed | 100% | Done |
| 2. Navigation Structure | ✅ Completed | 100% | Done |
| 3. Core Content Migration | 🔄 In Progress | 60% | May 10, 2025 |
| 4. Asset Migration | 🔄 In Progress | 40% | May 15, 2025 |
| 5. Styling & Customization | ⏳ Pending | 0% | May 20, 2025 |
| 6. Verification | ⏳ Pending | 0% | May 25, 2025 |
| 7. Deployment | ⏳ Pending | 0% | May 30, 2025 |

**Current Focus:** Migrating Concepts section content and associated assets

### Content Migration Status

| Section | Status | Progress |
|---------|--------|----------|
| Introduction & Getting Started | ✅ Completed | 100% |
| Concepts | 🔄 In Progress | 70% |
| How-Tos | 🔄 In Progress | 30% |
| Blocks-Toolbox | ⏳ Pending | 0% |
| Administration | ⏳ Pending | 0% |
| Installation | ⏳ Pending | 0% |
| Release Notes | ⏳ Pending | 0% |
| Resources | ⏳ Pending | 0% |

**Overall Migration Progress:** Approximately 45% complete

## Migration Overview

The migration will follow these high-level steps:

1. Set up the DocFX project structure
2. Migrate the navigation structure
3. Migrate core content pages
4. Migrate images and other assets
5. Implement styling and customization
6. Verify links and functionality
7. Deploy the migrated documentation

## Branching Strategy

Each step of the migration will be done on a separate feature branch. This allows for:

- Isolated work on specific migration tasks
- Easy review of changes through pull requests
- Ability to roll back changes if needed
- Parallel work on different migration tasks

The branch naming convention will be:

```
migrate/[section-name]/[specific-task]
```

For example:
- `migrate/navigation/main-toc`
- `migrate/content/getting-started`
- `migrate/assets/images`

**IMPORTANT:** Always create a new branch for each migration task and commit your changes to that branch. Do not make changes directly to the main branch. Follow these steps for each migration task:

1. Create a new branch for the task: `git checkout -b migrate/[section-name]/[specific-task]`
2. Make your changes
3. Add the changes to the staging area: `git add .`
4. Commit the changes: `git commit -m "Descriptive message about the changes"`
5. Push the changes to the remote repository: `git push -u origin migrate/[section-name]/[specific-task]`
6. Create a pull request (via GitHub UI)
7. After the PR is approved and merged, proceed to the next step

### Active Branches

| Branch | Purpose | Owner | Status |
|--------|---------|-------|--------|
| migrate/content/concepts | Migrating Concepts section | @developer1 | In Progress |
| migrate/assets/concept-images | Migrating Concept images | @developer2 | In Progress |

## Migration Steps

### Step 1: Set up the DocFX Project Structure ✅

**Status:** Completed on April 15, 2025

**Branch:** `migrate/setup/project-structure`

```bash
# Create and switch to the feature branch
git checkout main
git pull
git checkout -b migrate/setup/project-structure
```

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
Open a browser and navigate to `http://localhost:8080` to verify that the basic structure is in place.

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Set up DocFX project structure"
git push -u origin migrate/setup/project-structure

# Create pull request (via GitHub UI)
# After PR is approved and merged, proceed to the next step
```

**PR:** #12 (Merged)

### Step 2: Migrate the Main Navigation Structure ✅

**Status:** Completed on April 20, 2025

**Branch:** `migrate/navigation/main-toc`

```bash
# Create and switch to the feature branch
git checkout main
git pull
git checkout -b migrate/navigation/main-toc
```

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
Open a browser and navigate to `http://localhost:8080` to verify that the navigation structure matches the GitBook structure.

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate main navigation structure"
git push -u origin migrate/navigation/main-toc

# Create pull request (via GitHub UI)
# After PR is approved and merged, proceed to the next step
```

**PR:** #15 (Merged)

### Step 3: Migrate the Introduction and Getting Started Sections ✅

**Status:** Completed on April 25, 2025

**Branch:** `migrate/content/introduction-getting-started`

```bash
# Create and switch to the feature branch
git checkout main
git pull
git checkout -b migrate/content/introduction-getting-started
```

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
Open a browser and navigate to `http://localhost:8080` to verify that the Introduction and Getting Started sections display correctly.

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate Introduction and Getting Started sections"
git push -u origin migrate/content/introduction-getting-started

# Create pull request (via GitHub UI)
# After PR is approved and merged, proceed to the next step
```

**PR:** #18 (Merged)

### Step 4: Migrate the Concepts Section 🔄

**Status:** In Progress (70% complete)

**Branch:** `migrate/content/concepts`

```bash
# Create and switch to the feature branch
git checkout main
git pull
git checkout -b migrate/content/concepts
```

1. Create the concepts directory structure ✅
2. Migrate the Concepts section pages 🔄
   - Core concept pages ✅
   - Agent subsection 🔄 (In Progress)
   - Data Stream subsection 🔄 (In Progress)
   - Application subsection ✅
   - Insights subsection 🔄 (In Progress)
   - Recommendation subsection 🔄 (In Progress)
   - XMPro AI subsection 🔄 (In Progress)
3. Update links and references in these pages 🔄
4. Migrate images used in these pages 🔄

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that the Concepts section displays correctly.

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate Concepts section"
git push -u origin migrate/content/concepts

# Create pull request (via GitHub UI)
# After PR is approved and merged, proceed to the next step
```

**PR:** Not created yet

### Step 5: Migrate the How-Tos Section 🔄

**Status:** In Progress (30% complete)

**Branch:** `migrate/content/how-tos`

```bash
# Create and switch to the feature branch
git checkout main
git pull
git checkout -b migrate/content/how-tos
```

1. Create the how-tos directory structure ✅
2. Migrate the How-Tos section pages 🔄
   - Agents subsection 🔄 (In Progress)
   - Apps subsection ⏳ (Not Started)
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
Open a browser and navigate to `http://localhost:8080` to verify that the How-Tos section displays correctly.

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate How-Tos section"
git push -u origin migrate/content/how-tos

# Create pull request (via GitHub UI)
# After PR is approved and merged, proceed to the next step
```

**PR:** Not created yet

### Step 6: Migrate the Blocks-Toolbox Section ⏳

**Status:** Not Started

**Branch:** `migrate/content/blocks-toolbox`

```bash
# Create and switch to the feature branch
git checkout main
git pull
git checkout -b migrate/content/blocks-toolbox
```

1. Create the blocks-toolbox directory structure ⏳
2. Migrate the Blocks-Toolbox section pages ⏳
3. Update links and references in these pages ⏳
4. Migrate images used in these pages ⏳

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that the Blocks-Toolbox section displays correctly.

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate Blocks-Toolbox section"
git push -u origin migrate/content/blocks-toolbox

# Create pull request (via GitHub UI)
# After PR is approved and merged, proceed to the next step
```

**PR:** Not created yet

### Step 7: Migrate the Administration Section ⏳

**Status:** Not Started

**Branch:** `migrate/content/administration`

```bash
# Create and switch to the feature branch
git checkout main
git pull
git checkout -b migrate/content/administration
```

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
Open a browser and navigate to `http://localhost:8080` to verify that the Administration section displays correctly.

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate Administration section"
git push -u origin migrate/content/administration

# Create pull request (via GitHub UI)
# After PR is approved and merged, proceed to the next step
```

**PR:** Not created yet

### Step 8: Migrate the Installation Section ⏳

**Status:** Not Started

**Branch:** `migrate/content/installation`

```bash
# Create and switch to the feature branch
git checkout main
git pull
git checkout -b migrate/content/installation
```

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
Open a browser and navigate to `http://localhost:8080` to verify that the Installation section displays correctly.

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate Installation section"
git push -u origin migrate/content/installation

# Create pull request (via GitHub UI)
# After PR is approved and merged, proceed to the next step
```

**PR:** Not created yet

### Step 9: Migrate the Release Notes Section ⏳

**Status:** Not Started

**Branch:** `migrate/content/release-notes`

```bash
# Create and switch to the feature branch
git checkout main
git pull
git checkout -b migrate/content/release-notes
```

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
Open a browser and navigate to `http://localhost:8080` to verify that the Release Notes section displays correctly.

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate Release Notes section"
git push -u origin migrate/content/release-notes

# Create pull request (via GitHub UI)
# After PR is approved and merged, proceed to the next step
```

**PR:** Not created yet

### Step 10: Migrate the Resources Section (Last Priority) ⏳

**Status:** Not Started

**Branch:** `migrate/content/resources`

```bash
# Create and switch to the feature branch
git checkout main
git pull
git checkout -b migrate/content/resources
```

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
Open a browser and navigate to `http://localhost:8080` to verify that the Resources section displays correctly.

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Migrate Resources section"
git push -u origin migrate/content/resources

# Create pull request (via GitHub UI)
# After PR is approved and merged, proceed to the next step
```

**PR:** Not created yet

### Step 11: Implement Styling and Customization ⏳

**Status:** Not Started

**Branch:** `migrate/styling/customization`

```bash
# Create and switch to the feature branch
git checkout main
git pull
git checkout -b migrate/styling/customization
```

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
Open a browser and navigate to `http://localhost:8080` to verify that the styling and customization match the desired look and feel.

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Implement styling and customization"
git push -u origin migrate/styling/customization

# Create pull request (via GitHub UI)
# After PR is approved and merged, proceed to the next step
```

**PR:** Not created yet

### Step 12: Verify Links and Functionality ⏳

**Status:** Not Started

**Branch:** `migrate/verification/links-functionality`

```bash
# Create and switch to the feature branch
git checkout main
git pull
git checkout -b migrate/verification/links-functionality
```

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
Open a browser and navigate to `http://localhost:8080` to verify that all links and functionality work correctly.

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Verify links and functionality"
git push -u origin migrate/verification/links-functionality

# Create pull request (via GitHub UI)
# After PR is approved and merged, proceed to the next step
```

**PR:** Not created yet

### Step 13: Final Review and Deployment ⏳

**Status:** Not Started

**Branch:** `migrate/deployment/final`

```bash
# Create and switch to the feature branch
git checkout main
git pull
git checkout -b migrate/deployment/final
```

1. Perform a final review of the migrated documentation ⏳
2. Fix any remaining issues ⏳
3. Verify the GitHub Actions workflow for automatic deployment ⏳
4. Merge the final changes to the main branch to trigger deployment ⏳

**Verification:** 
```bash
# Build and serve the site locally
cd docs-docfx
docfx build
docfx serve _site
```
Open a browser and navigate to `http://localhost:8080` to verify that the documentation is ready for deployment.

After merging to main, verify that the deployed documentation works correctly on GitHub Pages.

**Completion:**
```bash
# Commit changes
git add .
git commit -m "Final review and deployment preparation"
git push -u origin migrate/deployment/final

# Create pull request (via GitHub UI)
# After PR is approved and merged, the site will be automatically deployed to GitHub Pages
```

**PR:** Not created yet

## Weekly Migration Status Meetings

To ensure the migration stays on track, weekly status meetings will be held every Monday at 10:00 AM. These meetings will:

1. Review progress from the previous week
2. Identify any blockers or issues
3. Assign tasks for the upcoming week
4. Update the migration plan and timeline as needed

Meeting notes will be recorded and shared with the team.

## Continuous Deployment

A GitHub Actions workflow has been set up to automatically deploy the documentation to GitHub Pages whenever changes are merged into the main branch. This ensures that each migration step is immediately visible on the public documentation site once it's completed and merged.

The deployment workflow is defined in `.github/workflows/deploy-docs.yml` and performs the following steps:

1. Checks out the repository
2. Sets up .NET
3. Installs DocFX
4. Builds the DocFX documentation
5. Deploys the built site to the gh-pages branch

This means that after each migration step is completed and the feature branch is merged into main, the changes will be automatically deployed to GitHub Pages. This allows for incremental deployment of the documentation as the migration progresses.

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
