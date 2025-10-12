require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "5.1.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '2195d76d498826a126b41e298d716d31550bac05ebd71f334f67926a296a0ee9',
     armv7l: '2195d76d498826a126b41e298d716d31550bac05ebd71f334f67926a296a0ee9',
       i686: '7702c09d0c0f113c60660ca98e55d8cbb89c92c87db511f6788dd9e4ae1d1269',
     x86_64: '729de7aa8fdb10b20f127ff108a2c9e72cd7c6f4eb078f3d9943b8182cd25aea'
  })

  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
