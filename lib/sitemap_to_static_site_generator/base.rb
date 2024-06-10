require "byebug"
require "nokogiri"
require "typhoeus"
require "addressable"
require "active_support/all"

class SitemapToStaticSiteGenerator::Base
	
	attr_accessor :host
	attr_accessor :output_directory
	attr_accessor :sitemap_url
	attr_accessor :pages_list

	def initialize(output_directory,sitemap_url)
		self.output_directory = output_directory
		self.sitemap_url = sitemap_url
		set_pages_list
	end

	def set_pages_list
		sitemap_doc = nil
		if self.sitemap_url =~ /https?\:/
			sitemap_doc = Nokogiri::XML(Typhoeus.get(self.sitemap_url).body)
			puts "got sitemap url"
		else
			sitemap_doc = Nokogiri::XML(IO.read(self.sitemap_url))
		end
		self.pages_list = sitemap_doc.css("loc").map{|t| t.text}
		puts "read #{self.pages_list.size} pages"
	end

	def get_relative_url(url)
		host_uri = Addressable::URI.parse(url)
		l2 = host_uri.scheme + "://#{host_uri.host}"
		relative_url = url.gsub(/#{Regexp.escape(l2)}/,'')
		relative_url
	end  

	

	# only leaves the matter of the public folder.
	# since that folders
	# contents
	def clean_output
		FileUtils.rm_r self.output_directory, :force => true
	end

	# if an html file exists, with the same name as a directory in the same folder, nginx will throw 404.
	# to solve this, we create a file in the directory by the name of index.html.
	# for eg if "languages.html" and "/languages" are both present in the same directory, we copy languages.html into /languages and name it as index.html.
	# then fix the nginx server block to look for this kind of file.
	# THIS WAS NOT REQUIRED.
	def fix_directories(directory=self.output_directory)
		while true
			directories = Dir.entries(directory).select {|entry| File.directory? File.join(directory,entry) and !(entry =='.' || entry == '..') }

		end
	end

	def build_static_site
		self.pages_list.each do |page|
			html = Typhoeus.get(page).body
			puts "paeg is #{page}"
			relative_path = get_relative_url(page)
			puts "basic relative path #{relative_path}"
			parts = relative_path.split(/\//)
			parts.reject!{|c|
				c.blank? or c.strip.blank?
			}
			puts "parts #{parts}"
			relative_path = parts[0..-2].join("/")
			relative_path = self.output_directory + "/" + relative_path
			FileUtils.mkdir_p relative_path
			puts "relative path #{relative_path}"
			if parts.blank?
				parts = ["index"]
			end
			fpath = relative_path + "/" + parts[-1] + ".html"
			IO.write(fpath,html)
		end
	end
	
end