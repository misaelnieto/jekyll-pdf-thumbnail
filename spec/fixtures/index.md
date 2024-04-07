---
title: Homepage
layout: null
pdf_file: /assets/sample_1.pdf
---

# {{ page.title }}

{% assign other_pd = 'sample_2.pdf' %}

- This is a link to [{{page.pdf_file}}]({{page.pdf_file | absolute_url}})
- This is a preview of ![sample_1.pdf]({{ page.pdf_file| pdf_thumbnail }})
- This is a link to [sample_2.pdf](/sample_2.pdf)
- This is a preview of ![sample_2.pdf]({{ "/sample_2.pdf" | pdf_thumbnail }})

