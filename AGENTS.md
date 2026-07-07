# Agent Guide: Personal Portfolio Generator

This repository contains a static site generator for a professional portfolio and CV, written in OCaml.

## 🚀 Project Overview

The project takes structured data (defined in OCaml) and raw documents (Org-mode/Markdown) and generates a clean, static HTML/CSS website. It also handles the conversion of a resume into both HTML and PDF formats.

### Tech Stack
- **Core Language**: OCaml
- **Build System**: [Dune](https://dune.ocaml.org/)
- **HTML Generation**: `Tyxml`
- **Markdown Parsing**: `Omd`
- **Document Conversion**: `pandoc` (for Org-mode $\rightarrow$ HTML/PDF)
- **PDF Engine**: `pdflatex`
- **Frontend**: Vanilla HTML & CSS
- **Interactive Tool**: JavaScript (contained in `/ALD`)
- **Deployment**: Docker

## 📂 Directory Structure

- `bin/`: Main entry point. `generate.ml` coordinates the build process.
- `lib/`: Core library logic.
    - `content.ml`: The "database" of the site. Contains profile information, skills, timeline, and open-source projects.
    - `render.ml`: Logic for converting OCaml data structures into HTML using `Tyxml`.
    - `cv.ml`: Logic for generating the CV HTML and PDF via `pandoc`.
    - `portfolio_lib.ml`: Module exports.
- `source/`: Raw content sources.
    - `resume.org`: The source of truth for the CV.
    - `cv-pdf.tex`: LaTeX header for customizing the PDF output.
- `static/`: Global CSS and static assets.
- `_site/`: The generated output directory (do not edit manually).
- `ALD/`: A separate interactive simulation tool for Atomic Layer Deposition (ALD) written in JavaScript.
- `docker/`: Scripts and configurations for containerized deployment.

## 🛠️ Development Workflow

### Generating the Site
1. **Build the project**:
   ```bash
   dune build
   ```
2. **Run the generator**:
   ```bash
   ./_build/default/bin/generate.exe
   ```
   *(Alternatively, if a Makefile is provided, use `make`)*.

### Updating Content
- **Portfolio Page**: Edit `lib/content.ml`.
- **CV/Resume**: Edit `source/resume.org`.
- **Styling**: Edit `static/style.css` or `static/cv.css`.

## 📜 Core Rules & Guidelines

1. **Type Safety**: When adding new fields to the profile or timeline, update the types in `lib/content.ml` first, then update the rendering logic in `lib/render.ml`.
2. **CV Pipeline**: The CV generation relies on external tools. Ensure `pandoc` and `pdflatex` are installed in the environment.
3. **Static Assets**: All assets in `static/` are copied to `_site/` during the build process.
4. **ALD Tool**: The `/ALD` directory is a standalone JS application. Changes there do not require an OCaml rebuild but should be tested in a browser.
5. **Consistency**: Keep the `resume.org` and `lib/content.ml` in sync where they overlap (e.g., professional experience).
