Gem::Specification.new do |gem|
    gem.name        = "jekyll-pdf-thumbnail"
    gem.version     = "0.1.0"
    gem.summary     = "Generates PNG thumbnails of your PDFs"
    gem.description = "This plugin generates thumbnails for each PDF in your site using the pdftoimage gem"
    gem.authors     = ["Noe Niet"]
    gem.email       = "nnieto@noenieto.com"
    gem.homepage    =
      "https://rubygems.org/gems/jekyll-pdf-thumbnail"
    gem.license       = "MIT"
    # Dependencies
    gem.add_dependency 'pdftoimage', '~> 0.2.0'
    gem.add_dependency 'jekyll', '~> 4.3', '< 5.0'

    # Dev dependencies
    gem.add_development_dependency "rake", "~> 12.3"
    gem.add_development_dependency "rspec", "~> 3.8"
    gem.add_development_dependency "debug", ">= 1.0.0"

    # Other stuff
    gem.files       = ["lib/jekyll-pdf-thumbnail.rb"]
    gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
    gem.require_paths = ["lib"]
  end