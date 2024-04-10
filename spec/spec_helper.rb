require 'jekyll'
require 'rspec'
require File.expand_path('../lib/jekyll-pdf-thumbnail', File.dirname(__FILE__))

Jekyll.logger.log_level = :error

RSpec.configure do |config|

  SOURCE_DIR = File.expand_path("../fixtures", __FILE__)
  DEST_DIR   = File.expand_path("../_site",  __FILE__)
  PDF_CACHE_DIR = File.expand_path('../_site/assets/pdf_thumbnails', __FILE__)
  FileUtils.rm_rf(DEST_DIR)
  FileUtils.mkdir_p(DEST_DIR)

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
