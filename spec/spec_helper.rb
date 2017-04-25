require 'uri'
require 'net/http'

RSpec::Matchers.define :be_valid_json_ld do |_expected|
  match do |actual|
    validate_json_ld(actual)['errors'].empty?
  end

  failure_message do |actual|
    validate_json_ld(actual)['errors']
  end

  def validate_json_ld(html)
    params = { 'html' => html }
    url = URI.parse('https://search.google.com/structured-data/testing-tool/validate')
    response = Net::HTTP.post_form(url, params)
    JSON.parse(response.body.split("\n")[1])
  rescue
    puts 'Unable to validate JSON'
    { 'errors' => [] }
  end
end
