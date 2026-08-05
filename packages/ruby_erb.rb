require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "6.0.7-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'de16867826127d1f7ce0e5c432d87f0e4812746d6f26e328ace5c7f73b18ee90',
     armv7l: 'de16867826127d1f7ce0e5c432d87f0e4812746d6f26e328ace5c7f73b18ee90',
       i686: 'ee203f0bc31f368435f767d4b1722f39711f390e0e296417815cab08914af83a',
     x86_64: 'a514c82bb4e9cbd8355b29b03c2dffc57c098e19d08d0bd0c1dd20801416bde0'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library
  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
