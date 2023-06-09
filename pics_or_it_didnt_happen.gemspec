# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'pics_or_it_didnt_happen'
  s.version = '1.1.3'
  s.license = 'MIT'
  s.author = 'Greg Matthew Crossley'
  s.homepage = 'https://github.com/NeomindLabs/pics_or_it_didnt_happen'
  s.summary = 'A Ruby gem that lets you include images in HTML using data URLs (and avoid serving the image file separatly). '
  s.description = <<~DESCRIPTION
    Sometimes, you might want your HTML to include a one-off image file that is just for one person. Making this file public may be undesireable for security reasons, or perhaps simply because it is not worth the overhead of multiple HTTP requests.
    This gem provides a utility method that takes a locally-saved image file, perhaps within your non-public tmp directory, encodes it as Base64, and returns an HTML <img> element with the correct data URL attributes.
    It is made possible by the RFC 2397 scheme, which is now fairly well supported in modern browsers.
  DESCRIPTION
  s.metadata = {
    'bug_tracker_uri' => "#{s.homepage}/issues",
    'documentation_uri' => s.homepage,
    'homepage_uri' => s.homepage,
    'source_code_uri' => s.homepage,
  }
  s.files = %w[lib/pics_or_it_didnt_happen.rb]
end
