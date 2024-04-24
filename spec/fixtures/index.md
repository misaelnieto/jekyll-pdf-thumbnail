---
title: Homepage
layout: null
pdf_file: /assets/sample_1.pdf
---

# {{ page.title }}

{% assign other_pdf = 'sample_2.pdf' %}

- This is a link to [{{page.pdf_file}}]({{page.pdf_file}})
- This is a preview of ![sample_1.pdf]({{ page.pdf_file| pdf_thumbnail }})
- This is a link to [sample_2.pdf]({{other_pdf }})
- This is a preview of ![sample_2.pdf]({{ other_pdf | pdf_thumbnail }})
- 50% resize: ({{page.pdf_file | pdf_thumbnail: resize:'50%' }})
- 25% resize: ({{page.pdf_file | pdf_thumbnail: resize:'25%' }})
- 25% resize, 50% quality: ({{page.pdf_file | pdf_thumbnail: resize:'25%', quality:'50'}})
- 12% resize, 25% quality: ({{page.pdf_file | pdf_thumbnail: resize:'12%', quality:'25'}})
