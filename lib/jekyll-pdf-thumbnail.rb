require 'pdftoimage'
require 'jekyll'
require "digest"



module PDFThumbnail
  CACHE_DIR = "/assets/pdf_thumbnails/"
  HASH_LENGTH = 32

  def _dest_filename(src_path)
    # Generates a thumbnail name using the SHA256 digest of the PDF file
    #
    # Example:
    #   >> _dest_filename("sample_1.pdf")
    #   => a35383ccca791ba6aa67ab3acde65287.png
    #
    # Arguments:
    #   src_path: (String)
    hash = Digest::SHA256.file(src_path)
    short_hash = hash.hexdigest()[0, HASH_LENGTH]
    "#{short_hash}.png"
  end

  def _must_create?(src_path, dest_path)
    # Returns true if dest_path doesn't exists or src_path is newer than dest_path
    !File.exist?(dest_path) || File.mtime(dest_path) <= File.mtime(src_path)
  end


  # The PDF thumbnail generator
  class Generator < Jekyll::Generator
    include PDFThumbnail
    def generate(site)
      # Ensure the cache dir exists
      full_cache_path = File.join(site.source, CACHE_DIR)
      FileUtils.mkdir_p(full_cache_path)

      site.static_files.each do |static_file|
        if static_file.extname.downcase == ".pdf"
          full_pdf_path = File.join(site.source, static_file.relative_path)
          thumb = _dest_filename(full_pdf_path)
          full_thumb_path = File.join(full_cache_path, thumb)
          rel_thumb_path = File.join(CACHE_DIR, thumb)
          if _must_create?(full_pdf_path, full_thumb_path)
            puts "Creating thumbnail of' #{static_file.relative_path}' to '#{rel_thumb_path}'"
            PDFToImage.open(full_pdf_path).first.resize('50%').save(full_thumb_path)
            site.static_files << Jekyll::StaticFile.new(site, site.source, CACHE_DIR, thumb)
          end
        end
      end
    end
  end

  module Filters
    include PDFThumbnail

    def pdf_thumbnail(pdf)
      # Returns the thumbnail path for a given pdf file.
      # Example:
      #   >> pdf_thumbnail "/path/to/sample_1.pdf"
      #   => /assets/pdf_thumbnails/a35383ccca791ba6aa67ab3acde65287.png
      #
      # Or as a liquid filter:
      #  {% assign my_pdf = 'sample_2.pdf' %}
      #  {{ my_pdf | pdf_preview }}
      #
      # Arguments:
      #   pdf: (String)
      site = @context.registers[:site]
      full_pdf_path = File.join(site.source, pdf)
      File.join(CACHE_DIR, _dest_filename(full_pdf_path))
    end
  end

end

Liquid::Template.register_filter(PDFThumbnail::Filters)
