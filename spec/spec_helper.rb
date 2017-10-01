require 'uri'
require 'net/http'

class UserLimitedError < StandardError
  attr_reader :msg
  def initialize(msg = 'The webpage responded with a 302 error code.')
    super(msg)
  end
end

RSpec::Matchers.define :be_valid_json_ld do |_expected|
  match do |actual|
    validate_json_ld(actual)['errors'].empty?
  end

  failure_message do |actual|
    validate_json_ld(actual)['errors']
  end

  def validate_json_ld(html)
    sleep(rand(2..5)) # Prevent getting rate limited by Google.
    params = { 'html' => html }
    url = URI.parse('https://search.google.com/structured-data/testing-tool/validate')
    response = Net::HTTP.post_form(url, params)

    if response.code == '302'
      raise UserLimitedError, 'This account has likely become temporarily rate limited. (Response code 302).'
    end

    JSON.parse(response.body.split("\n")[1])
  rescue JSON::ParserError
    puts 'Unable to validate JSON'
    { 'errors' => [] }
  rescue UserLimitedError => e
    puts e
  end
end
