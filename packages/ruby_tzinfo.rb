require 'buildsystems/ruby'

class Ruby_tzinfo < RUBY
  description 'Tzinfo provides access to time zone data and allows times to be converted using time zone rules.'
  homepage 'https://tzinfo.github.io'
  version "2.0.6-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_concurrent_ruby' # R

  conflicts_ok
  no_compile_needed
end
