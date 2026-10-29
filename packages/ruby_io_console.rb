require 'buildsystems/ruby'

class Ruby_io_console < RUBY
  description 'add console capabilities to IO instances.'
  homepage 'https://github.com/ruby/io-console'
  version "0.9.5-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'ffefcbb5d16648758341f9090fca95df53e63bd1d06c338bc9bdd1b4f903c9da',
     armv7l: 'ffefcbb5d16648758341f9090fca95df53e63bd1d06c338bc9bdd1b4f903c9da',
       i686: '3162eea4f9ba2b42097e136f7acd586920a1b4c1d8d3e20f67e723b561fd739c',
     x86_64: '882073224256e99bae526919ab0321f3da207bbba93840d9f0311d6a9b928c29'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
