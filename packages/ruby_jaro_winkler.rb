require 'buildsystems/ruby'

class Ruby_jaro_winkler < RUBY
  description 'Jaro_winkler is an implementation of Jaro-Winkler distance algorithm which is written in C extension and will fallback to pure Ruby version in platforms other than MRI/KRI like JRuby or Rubinius.'
  homepage 'https://github.com/tonytonyjan/jaro_winkler'
  version "1.7.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'b73c4e0d60f72bc759b8eb5a88fe9a7c8286f516b55bf225c9700443d22ad936',
     armv7l: 'b73c4e0d60f72bc759b8eb5a88fe9a7c8286f516b55bf225c9700443d22ad936',
       i686: '96c78c74b973a935acd43cca1b8f7bcb2b0138e53344b305e6d03ddede2867b4',
     x86_64: '8a3a66de59b9acf35affd9b718c0bee54e3e1e9b6247e464a2798e79c71ba713'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
  upstream_name 'jaro_winkler'
end
