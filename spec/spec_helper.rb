require 'jekyll'
require 'rspec'
require File.expand_path('../lib/jekyll-pdf-thumbnail', File.dirname(__FILE__))

Jekyll.logger.log_level = :error

RSpec.configure do |config|

  SOURCE_DIR = File.expand_path("../fixtures", __FILE__)
  DEST_DIR   = File.expand_path("_site",  SOURCE_DIR)
  PDF_CACHE_DIR = File.expand_path('assets/pdf_thumbnails', SOURCE_DIR)
  FileUtils.rm_rf(DEST_DIR)
  FileUtils.rm_rf(PDF_CACHE_DIR)
  FileUtils.rm_rf(File.expand_path(".jekyll-cache",  SOURCE_DIR))

  def source_dir(*files)
    File.join(SOURCE_DIR, *files)
  end

  def dest_dir(*files)
    File.join(DEST_DIR, *files)
  end

  def pdf_cache_dir(*files)
    File.join(PDF_CACHE_DIR, *files)
  end

  def make_context(registers = {})
    Liquid::Context.new({}, {}, { site: site }.merge(registers))
  end
end
