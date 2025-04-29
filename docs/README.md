# DocFX Documentation Site

This directory contains the DocFX documentation site for the project.

## Important Notes

- **This documentation should be maintained on the `gh-pages` branch**, not on the `main` branch.
- The GitHub Actions workflow (`.github/workflows/docfx.yml`) is configured to build the documentation from this directory and deploy it to GitHub Pages.
- The site is built using DocFX and deployed to GitHub Pages using the GitHub Actions workflow.

## Local Development

To preview the documentation locally:

1. Install DocFX:
   ```bash
   dotnet tool install -g docfx
   ```

2. Build the documentation:
   ```bash
   cd docs
   docfx build
   ```

3. Serve the documentation locally:
   ```bash
   docfx serve _site
   ```

4. Open your browser and go to `http://localhost:8080` to view the documentation.

## Directory Structure

- `docs/` - The root directory for the documentation
  - `docs/` - Documentation content
  - `images/` - Images used in the documentation
  - `_site/` - Generated site (not committed to the repository)
  - `docfx.json` - DocFX configuration file
  - `toc.yml` - Table of contents for the documentation

## Workflow

1. Make changes to the documentation on the `gh-pages` branch
2. Commit and push the changes to the `gh-pages` branch
3. The GitHub Actions workflow will automatically build and deploy the documentation to GitHub Pages

## Notes

- The `main` branch should not contain the documentation files, as they are maintained on the `gh-pages` branch.
- The GitHub Actions workflow is triggered by pushes to the `main` branch, but it checks out the repository and builds the documentation from the `docs` directory on the `gh-pages` branch.
