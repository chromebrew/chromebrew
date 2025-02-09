require 'buildsystems/ruby'

class Ruby_rubocop_chromebrew < RUBY
  description 'A RuboCop extension to enforce Chromebrew-specific practices.'
  homepage 'https://github.com/chromebrew/rubocop-chromebrew'
  version "0.0.3-#{CREW_RUBY_VER}"
  license 'GPL-3.0-or-later'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_rubocop' # R

  conflicts_ok
  no_compile_needed
end
