# frozen_string_literal: true

require_relative "lib/sitemap_to_static_site_generator/version"

Gem::Specification.new do |spec|
  spec.name = "sitemap_to_static_site_generator"
  spec.version = SitemapToStaticSiteGenerator::VERSION
  spec.authors = ["Method Fast Team"]
  spec.email = ["methofast.com@outlook.com"]

  spec.summary = "Converts a sitemap into a directory of static html pages, suitable for nginx or apache"
  spec.description = "Given a sitemap, this gem will download each page and build a directory structure that mimics the url paths. You can then simply paste the directory into nginx/apache and render pages without the need for a webserver. Useful for sites with 100% static pages, to reduce hosting costs and the overhead of maintaining a web app."
  spec.homepage = "https://www.methodfast.com"
  spec.license = "GPLV3"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "https://www.rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.github.com/wordjelly/sitemap-to-static-site-generator"
  spec.metadata["changelog_uri"] = "https://www.github.com/wordjelly/sitemap-to-static-site-generator/CHANGELOG.md"

=begin
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
=end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "typhoeus"
  spec.add_dependency "activesupport"
  spec.add_dependency "byebug"
  spec.add_dependency "nokogiri"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
