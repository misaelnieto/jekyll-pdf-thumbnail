require 'pdftoimage'
require 'jekyll'
require "digest"



module PDFThumbnail
  CACHE_DIR = "/assets/.pdf_thumbnails/"
  HASH_LENGTH = 32

  def _dest_filename(src_path)
    hash = Digest::SHA256.file(src_path)
    short_hash = hash.hexdigest()[0, HASH_LENGTH]
    "#{short_hash}.png"
  end

  def _must_create?(src_path, dest_path)
    !File.exist?(dest_path) || File.mtime(dest_path) <= File.mtime(src_path)
  end


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
      site = @context.registers[:site]
      full_pdf_path = File.join(site.source, pdf)
      File.join(site.dest, CACHE_DIR, _dest_filename(full_pdf_path))
    end
  end

end

Liquid::Template.register_filter(PDFThumbnail::Filters)
