require "json"
require "open-uri"

RSpec.describe "Test JSON" do
  context "validating" do
      let(:html) do
        %(<script type="application/ld+json">
{"@context": "http://schema.org",
"@type": "BlogPosting",
"headline": "Improving Jekyll in 2017",
"author": {"@type": "Person",
"name": "Kyle Niewiada"},
"image": {"@type": "ImageObject",
"url": "https://www.kyleniewiada.org/assets/img/2017/02/banner.png",
"height": 400,
"width": 700},
"datePublished": "2017-02-22T05:34:00-05:00",
"dateModified": "2017-02-27T13:18:25-05:00",
"description": "My Jekyll website needed an update; so I fixed that. This is how I added tests, Travis-CI builds, Accelerated Mobile Pages, SEO improvements, and more.",
"publisher": {"@type": "Organization",
"name": "Kyle Niewiada",
"logo": {"@type": "ImageObject",
"url": "https://www.kyleniewiada.org/assets/img/logo.png"}},
"mainEntityOfPage": {"@type": "WebPage",
"@id": "https://www.kyleniewiada.org/blog/2017/02/improving-jekyll-2017/"},
"url": "https://www.kyleniewiada.org/blog/2017/02/improving-jekyll-2017/"}</script>)
      end

      let(:html_invalid) do
        %(<script type="application/ld+json">
{"@context": "http://schema.org",
"@type": "BlogPosting",
"headline": "Improving Jekyll in 2017",
"author": {"@type": "Person",
"name": "Kyle Niewiada"},
"image": {"@type": "ImageObject",
"url": "https://www.kyleniewiada.org/assets/img/2017/02/banner.png",
"height": 400,
"width": 700},
"dateModified": "2017-02-27T13:18:25-05:00",
"description": "My Jekyll website needed an update; so I fixed that. This is how I added tests, Travis-CI builds, Accelerated Mobile Pages, SEO improvements, and more.",
"publisher": {"@type": "Organization",
"name": "Kyle Niewiada",
"logo": {"@type": "ImageObject",
"url": "https://www.kyleniewiada.org/assets/img/logo.png"}},
"mainEntityOfPage": {"@type": "WebPage",
"@id": "https://www.kyleniewiada.org/blog/2017/02/improving-jekyll-2017/"},
"url": "https://www.kyleniewiada.org/blog/2017/02/improving-jekyll-2017/"}</script>)
      end

      it "validates" do
        expect(html).to be_valid_json_ld
      end

      it "does not validate" do
        expect(html_invalid).not_to be_valid_json_ld
      end
    end
end
