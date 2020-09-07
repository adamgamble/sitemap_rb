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
end
