# Jekyll PDF thumbnails generator

A Jekyll plugin to generate thumbnails for your PDF files


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

```markdown
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
    - 50% resize: {{page.pdf_file | pdf_thumbnail: resize:'50%' }}
    - 25% resize: {{page.pdf_file | pdf_thumbnail: resize:'25%' }}
    - 25% resize, 50% quality: {{page.pdf_file | pdf_thumbnail: resize:'25%', quality:'50'}}
```

- The format of the `resize` parameter is the **image geometry** as defined in the [ImageMagick manual](https://imagemagick.org/script/command-line-processing.php#geometry).
- The format of the `quality` parameter is a number between 1 and 100 as defined in the [Image Magick manual](https://imagemagick.org/script/command-line-options.php#quality). Currently, only png thumbnails are supported. According to the manual: 
  > ... the quality value sets the zlib compression level (quality / 10) and filter-type (quality % 10). The default PNG "quality" is 75, which means compression level 7 with adaptive PNG filtering, unless the image has a color map, in which case it means compression level 7 with no PNG filtering.

## Developing this extension



- **Setup**: Clone the extension and execute `bundle install` to install the dependencies
- **Run tests**: ``bundle exec rspec``
- **Releasing a new version**
  - Update [jekyll-pdf-thumbnail.gemspec](jekyll-pdf-thumbnail.gemspec) with new version and metadata.
  - Commit your changes.
  - Create a new git tag:  `git tag -a vx.y.z -m "Version x.y.z"`
  - Push all the changes to github: `git push origin && git push origin --tags`
  - Build the Gem: ``gem build``
  - Upload the new gem: ``gem push jekyll-pdf-thumbnail-x.y.z.gem``

