module SitemapRb
  class Sitemap
    attr_reader :sitemap_hash
def initialize
      @sitemap_hash = {}
    end

    def load_from_file path
      parse
    end

    def load_from_url url
      @xml = open(url)
      parse
    end

    private 

    def parse
      @parser = Nokogiri::XML(@xml)
      enumerate_sitemaps
      enumerate_links
      @sitemap_hash
    end

    # Some sitemaps are indexes of other sitemaps
    def enumerate_sitemaps
      @sitemap_hash[:sitemaps] ||= []

      sitemap_rows = @parser.css('sitemap')
      sitemap_rows.each do |row|
        hash = {}
        if row.css('loc').first
          hash[:url] = row.css('loc').first.text
        end
        if row.css('lastmod').first
          hash[:last_modified] = row.css('lastmod').first.text
        end
        @sitemap_hash[:sitemaps] << hash
      end
    end

    def enumerate_links
      @sitemap_hash[:urls] ||= []

      url_rows = @parser.css('url')
      url_rows.each do |row|
        hash = {}
        if row.css('loc').first
          hash[:url] = row.css('loc').first.text
        end
        if row.css('lastmod').first
          hash[:last_modified] = row.css('lastmod').first.text
        end
        if row.css('changefreq').first
          hash[:change_frequency] = row.css('changefreq').first.text
        end
        if row.css('image|image').any?
          hash[:images] = []
          row.css('image|image').each do |image_row|
            image_hash = {}
            image_hash[:url] = image_row.css('image|loc').text
            image_hash[:title] = image_row.css('image|title').text
            hash[:images] << image_hash
          end
        end
        @sitemap_hash[:urls] << hash
      end
    end
  end
end
