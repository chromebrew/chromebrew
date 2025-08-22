require 'buildsystems/ruby'

class Ruby_unicode_display_width < RUBY
  description 'Determines the monospace display width of a string in Ruby, which is useful for all kinds of terminal-based applications.'
  homepage 'https://github.com/janlelis/unicode-display_width'
  version "3.1.5-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_unicode_emoji' # R

  conflicts_ok
  no_compile_needed
end
