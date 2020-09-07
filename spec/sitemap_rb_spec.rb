RSpec.describe SitemapRb do
  describe "Indexes" do
    let(:sitemap_path) { File.join('spec', 'support', 'index_sitemap.xml')}
    let(:sitemap) { SitemapRb::Sitemap.new }

    before do
      @results = sitemap.load_from_file(sitemap_path)
    end

    it "should grab the sitemap rows" do
      expect(@results[:sitemaps].count).to eq(15)
    end

    it "should contain urls and last modified" do
      expect(@results[:sitemaps].first).to eq({url: 'https://www.example.com/search-sitemap.xml', last_modified: '2020-09-07T00:00:40+00:00'})
    end

    it "should not contain anything but sitemaps" do
      expect(@results.keys).to eq([:sitemaps])
    end
  end
  describe "urls" do
    let(:sitemap_path) { File.join('spec', 'support', 'url_sitemap.xml')}
    let(:sitemap) { SitemapRb::Sitemap.new }

    before do
      @results = sitemap.load_from_file(sitemap_path)
    end

    it "should grab the sitemap rows" do
      expect(@results[:urls].count).to eq(4)
    end

    it "should contain urls and last modified" do
      expect(@results[:urls].first).to eq({change_frequency: 'daily', url: 'https://www.vecteezy.com/vector-art/131429-sweet-16-watercolor-background', last_modified: '2020-09-07T00:01:56+00:00', images: [{:title=>"Sweet 16 Watercolor Background", :url=>"https://static.vecteezy.com/system/resources/previews/000/131/429/original/vector-sweet-16-watercolor-background.jpg"}, {:title=>"Sweet 16 Watercolor Background", :url=>"https://static.vecteezy.com/system/resources/previews/000/131/429/non_2x/vector-sweet-16-watercolor-background.jpg"}, {:title=>"Sweet 16 Watercolor Background", :url=>"https://static.vecteezy.com/system/resources/previews/000/131/429/large_2x/vector-sweet-16-watercolor-background.jpg"}, {:title=>"Sweet 16 Watercolor Background", :url=>"https://static.vecteezy.com/system/resources/thumbnails/000/131/429/original/sweet-16-watercolor-background.jpg"}]})
    end
  end
end
