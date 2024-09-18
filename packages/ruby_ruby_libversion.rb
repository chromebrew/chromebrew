require 'buildsystems/ruby'

class Ruby_ruby_libversion < RUBY
  description 'Ruby bindings for libversion.'
  homepage 'https://github.com/Zopolis4/ruby-libversion'
  version '1.0.0-1-ruby-3.3'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'libversion' # R
  gem_compile_needed
  no_source_build
end
