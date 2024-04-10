require 'spec_helper'
require 'jekyll-pdf-thumbnail'
require 'debug'

describe "JekyllPDFThumbnail" do
    let(:overrides) { Hash.new }
    let(:config) do
        Jekyll.configuration(Jekyll::Utils.deep_merge_hashes({
          "full_rebuild" => true,
          "source"      => source_dir,
          "destination" => dest_dir,
          "show_drafts" => true,
          "url"         => "http://example.org",
          "name"       => "My awesome site",
          "author"      => {
            "name"        => "Dr. Jekyll"
          },
          "collections" => {
            "my_collection" => { "output" => true },
            "other_things"  => { "output" => false }
          }
        }, overrides))
      end
      let(:site)     { Jekyll::Site.new(config) }
      let(:context)  { make_context(site: site) }
      let(:contents) { File.read(dest_dir("index.html")) }
    
    context "pdf-thumbnail-on-jekyll" do
        it 'should register PDFThumbnail generator' do
          (expect (site.generators.any? {|c| PDFThumbnail::Generator === c })).to be true
        end
        it "Created thumbnail images for the sample PDFS" do
          expect { site.process }.to_not raise_error
            expect(Pathname.new(dest_dir("assets/sample_1.pdf"))).to exist
            expect(Pathname.new(dest_dir("sample_2.pdf"))).to exist
            expect(Pathname.new(pdf_cache_dir("a35383ccca791ba6aa67ab3acde65287.png"))).to exist
            expect(Pathname.new(pdf_cache_dir("75583f81ab86102df192c2f54de50183.png"))).to exist
        end

        it 'generated the correct html markup' do
          (expect contents).to include '<li>This is a link to <a href="http://example.org/assets/sample_1.pdf">/assets/sample_1.pdf</a></li>'
          (expect contents).to include '<li>This is a preview of <img src="/assets/pdf_thumbnails/a35383ccca791ba6aa67ab3acde65287.png" alt="sample_1.pdf" /></li>'
          (expect contents).to include '<li>This is a link to <a href="http://example.org/sample_2.pdf">sample_2.pdf</a></li>'
          (expect contents).to include '<li>This is a preview of <img src="/assets/pdf_thumbnails/75583f81ab86102df192c2f54de50183.png" alt="sample_2.pdf" /></li>'
        end
    end
end
