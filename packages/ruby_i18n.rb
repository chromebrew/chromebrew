require 'buildsystems/ruby'

class Ruby_i18n < RUBY
  description 'New wave internationalization support for ruby.'
  homepage 'https://github.com/ruby-i18n/i18n'
  version "1.14.7-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_concurrent_ruby' # R

  conflicts_ok
  no_compile_needed
end
