require 'pdftoimage'
require 'jekyll'
require "digest"
require 'debug'


module PDFThumbnail


  CACHE_DIR = "/assets/pdf_thumbnails/"
  HASH_LENGTH = 32
  @@cache_dir_present = false

  def _get_cache_dir(site)
    full_cache_dir = File.join(site.source, CACHE_DIR)
    if not @@cache_dir_present
      FileUtils.mkdir_p(full_cache_dir)
      @@cache_dir_present = true
    end
    full_cache_dir
  end

  def _dest_filename(src_path, resize, quality)
    # Generates a thumbnail name using the SHA256 digest of the PDF file
    #
    # Example:
    #   >> _dest_filename("sample_1.pdf")
    #   => a35383ccca791ba6aa67ab3acde65287.png
    #
    # Arguments:
    #   src_path: (String)
    #   resize: (String) as used in the -resize parameter of convert
    #   quality: (String) as used in the -quality parameter of convert
    hash = Digest::SHA256.file(src_path)
    short_hash = hash.hexdigest()[0, HASH_LENGTH]
    basename = short_hash
    if resize
      cleaned = resize.gsub(/[^\da-z]+/i, "")
      basename << "_r#{cleaned}"
    end
    if quality
      cleaned = quality.gsub(/[^\da-z]+/i, "")
      basename << "_q#{cleaned}"
    end
    basename << ".png"
  end

  def _must_create?(src_path, dest_path)
    # Returns true if dest_path doesn't exists or src_path is newer than dest_path
    !File.exist?(dest_path) || File.mtime(dest_path) <= File.mtime(src_path)
  end

  def generate_thumbnail(pdf, thumbnail, resize='50%', quality="80%")
    first = PDFToImage.open(pdf).first
    first.args << "-thumbnail #{resize}"
    first.save(thumbnail)
  end

  module Filters
    include PDFThumbnail

    def pdf_thumbnail(pdf, args=nil)
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
      #   args: a dict that can contain "resize" and "quality"
      if args == nil
        args = {"resize"=> "50%", "quality": '80%'}
      end
      resize = args.fetch("resize", "50%")
      quality = args.fetch("quality", "80%")
      site = @context.registers[:site]
      full_cache_dir = _get_cache_dir(site)
      full_pdf_path = File.join(site.source, pdf)
      thumbnail = _dest_filename(full_pdf_path, resize, quality)
      rel_thumb_path = File.join(CACHE_DIR, thumbnail)
      full_thumb_path = File.join(_get_cache_dir(site), thumbnail)
      if _must_create?(full_pdf_path, full_thumb_path)
        puts "Creating thumbnail of' #{pdf}' to '#{rel_thumb_path}'"
        generate_thumbnail(full_pdf_path, full_thumb_path, resize, quality)
        # site - The Site. 
        # base - The String path to the <source>. 
        # dir - The String path between <source> and the file. 
        # name - The String filename of the file.
        site.static_files << Jekyll::StaticFile.new(site, site.source, CACHE_DIR, thumbnail)
      end
      rel_thumb_path
    end
  end

end

Liquid::Template.register_filter(PDFThumbnail::Filters)
