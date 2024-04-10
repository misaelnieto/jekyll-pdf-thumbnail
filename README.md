# Jekyll PDF thumbnails generator

A Jekyll plugin to generate thumbnails for all PDF files.


## Usage

1. Add the following to your site's Gemfile:

  ```ruby
  gem 'jekyll-pdf-thumbnail'
  ```

2. Add the following to your site's config file:

  ```yml
  plugins:
    - jekyll-pdf-thumbnail
  ```

3. Use it in your `.md` files and liquid templates. Example markdown file:

```md
    ---
    title: Homepage
    layout: null
    pdf_file: /assets/sample_1.pdf
    ---
    # {{ page.title }}

    {% assign other_pdf = 'sample_2.pdf' %}

    - This is a link to [{{page.pdf_file}}]({{page.pdf_file | absolute_url}})
    - This is a preview of ![sample_1.pdf]({{ page.pdf_file| pdf_thumbnail }})
    - This is a link to [sample_2.pdf]({{other_pdf | absolute_url }})
    - This is a preview of ![sample_2.pdf]({{ other_pdf | pdf_thumbnail }})
```

