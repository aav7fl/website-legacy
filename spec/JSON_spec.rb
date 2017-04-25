require 'json'
require 'open-uri'

RSpec.describe 'Test JSON-LD' do
  context 'validating examples' do
    let(:html_valid) do
      %(<script type="application/ld+json">
      {"@context": "http://schema.org",
      "@type": "BlogPosting",
      "headline": "Test Headline",
      "author": {"@type": "Person",
      "name": "Kyle Niewiada"},
      "image": {"@type": "ImageObject",
      "url": "https://www.kyleniewiada.org/assets/img/banner.png",
      "height": 400,
      "width": 700},
      "datePublished": "2017-02-22T05:34:00-05:00",
      "dateModified": "2017-02-27T13:18:25-05:00",
      "description": "Test description",
      "publisher": {"@type": "Organization",
      "name": "Kyle Niewiada",
      "logo": {"@type": "ImageObject",
      "url": "https://www.kyleniewiada.org/assets/img/logo.png"}},
      "mainEntityOfPage": {"@type": "WebPage",
      "@id": "https://www.kyleniewiada.org/blog/test/"},
      "url": "https://www.kyleniewiada.org/blog/test/"}</script>)
    end

    let(:html_invalid) do
      %(<script type="application/ld+json">
      {"@context": "http://schema.org",
      "@type": "BlogPosting",
      "headline": "Test Headline",
      "author": {"@type": "Person",
      "name": "Kyle Niewiada"},
      "image": {"@type": "ImageObject",
      "url": "https://www.kyleniewiada.org/assets/img/banner.png",
      "height": 400,
      "width": 700},
      "description": "Test description",
      "publisher": {"@type": "Organization",
      "name": "Kyle Niewiada",
      "logo": {"@type": "ImageObject",
      "url": "https://www.kyleniewiada.org/assets/img/logo.png"}},
      "mainEntityOfPage": {"@type": "WebPage",
      "@id": "https://www.kyleniewiada.org/blog/test/"},
      "url": "https://www.kyleniewiada.org/blog/test/"}</script>)
    end

    it 'validates' do
      expect(html_valid).to be_valid_json_ld
    end

    it 'does not validate' do
      expect(html_invalid).not_to be_valid_json_ld
    end
  end

  context 'validating pages' do
    str_start = %(<script type="application/ld\\+json">)
    str_end = %(</script>)

    Dir.glob('_site/**/*.html') do |my_html_file|
      context my_html_file.to_s do
        let(:html) do
          IO.read(my_html_file.to_s)[/#{str_start}(.*?)#{str_end}/m, 1]
        end

        it 'validates' do
          expect(html).to be_valid_json_ld
        end
      end
    end
  end
end
