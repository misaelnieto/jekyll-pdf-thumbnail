Gem::Specification.new do |spec|
    spec.name        = "jekyll-pdf-thumbnail"
    spec.version     = "0.3.0"
    spec.summary     = "Generates PNG thumbnails of your PDFs"
    spec.description = "This plugin generates thumbnails for each PDF in your site using the pdftoimage gem"
    spec.authors     = ["Noe Nieto"]
    spec.email       = "nnieto@noenieto.com"
    spec.homepage    = "https://rubygems.org/gems/jekyll-pdf-thumbnail"
    spec.license     = "MIT"
    spec.files       = Dir["lib/**/*"]
    spec.extra_rdoc_files = Dir["README.md", "LICENSE.txt"]
    spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
    spec.require_paths = ["lib"]
    spec.required_ruby_version = ">= 2.5.0"
    spec.add_dependency 'pdftoimage', '~> 0.2.0'
    spec.add_dependency 'jekyll', '>= 3.7', '< 5.0'
    spec.add_development_dependency "rake", "~> 12.3"
    spec.add_development_dependency "rspec", "~> 3.8"
    # spec.add_development_dependency 'debug', '~> 1.0', '>= 1.0.0'
  end
