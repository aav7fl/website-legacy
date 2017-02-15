# Prevent bundler errors
module Liquid; class Tag; end; end

module Jekyll
  class SeoTag < Liquid::Tag
    VERSION_CUSTOM = "2.1.0".freeze
  end
end
