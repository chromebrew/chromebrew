require 'buildsystems/ruby'

class Ruby_unicode_emoji < RUBY
  description 'Provides various sophisticated regular expressions to work with Emoji in strings, incorporating the latest Unicode / Emoji standards.'
  homepage 'https://github.com/janlelis/unicode-emoji'
  version "4.0.4-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
