# frozen_string_literal: true

require "test_helper"

class TestSitemapToStaticSiteGenerator < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SitemapToStaticSiteGenerator::VERSION
  end

  def test_creates_static_directory
    output_path = ((__FILE__.split(/\//)[0..-3].join("/") + "/output"))
    puts output_path.to_s
    client = SitemapToStaticSiteGenerator::Base.new(output_path,"https://www.methodfast.com/sitemap.xml")
    client.clean_output
    client.build_static_site
  end

end
