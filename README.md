# Personal site: resume and blog

A small Jekyll site that GitHub Pages builds automatically. No theme gem and no build pipeline to maintain.

## 1. Publish it (one time)

1. On GitHub, create a **public** repository named exactly `tkdesai13.github.io` (your username).
2. In `_config.yml`, replace `tkdesai13` (twice) with your GitHub username and fill in `linkedin` / `scholar` if you want those links.
3. Push these files:

   ```bash
   cd site
   git init -b main
   git add .
   git commit -m "Initial site"
   git remote add origin https://github.com/tkdesai13/tkdesai13.github.io.git
   git push -u origin main
   ```

4. In the repo: **Settings → Pages → Build and deployment → Source: Deploy from a branch → `main` / `(root)`**.
   After a minute or two the site is live at `https://tkdesai13.github.io`.

## 2. Fill in the gaps

Search for `EDIT` in `resume.md`: thesis title, MSc programme and years, publications, extra skills.
Optional: add `assets/img/portrait.jpg` (then uncomment the `<img>` line in `index.md`) and `assets/files/cv.pdf`.

## 3. Write a post

Create `_posts/YYYY-MM-DD-some-title.md`:

```markdown
---
title: "Some title"
summary: One line for the blog index.
tags: [batteries]
---

Text in Markdown. Maths with $x$ and $$...$$ works.
```

Commit and push; GitHub rebuilds the site. Unfinished posts can live in `_drafts/` (not published).
You can also write and commit posts directly in the GitHub web editor.

## Preview locally (optional)

```bash
bundle install
bundle exec jekyll serve --drafts --livereload
# open http://localhost:4000
```

## Structure

```
_config.yml        site settings, name, links, navigation
index.md           About page (home)
resume.md          Resume
blog.md            Blog index, grouped by year
_posts/            published posts
_drafts/           unpublished drafts and a post template
_layouts/          page and post templates
_includes/         header, footer, <head>
assets/css/        stylesheet
```

Also included: RSS feed at `/feed.xml`, sitemap, SEO/social preview tags, light/dark mode, print-friendly resume page.
