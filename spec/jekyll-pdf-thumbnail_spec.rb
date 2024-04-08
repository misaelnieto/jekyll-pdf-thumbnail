require 'spec_helper'
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

    context "pdf-thumbnail" do
        it "Created thumbnail images for the sample PDFS" do
          expect { site.process }.to_not raise_error
            expect(Pathname.new(dest_dir("assets/sample_1.pdf"))).to exist
            expect(Pathname.new(dest_dir("sample_2.pdf"))).to exist
            expect(Pathname.new(pdf_cache_dir("a35383ccca791ba6aa67ab3acde65287.png"))).to exist
            expect(Pathname.new(pdf_cache_dir("75583f81ab86102df192c2f54de50183.png"))).to exist
        end
    end
end
