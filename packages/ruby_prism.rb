require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "1.9.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'ec34919dbfa8200ec0c7af082aa5360fe0af7f9521e19e076390df6fcf061807',
     armv7l: 'ec34919dbfa8200ec0c7af082aa5360fe0af7f9521e19e076390df6fcf061807',
       i686: '14361a0eac94676c323e5ecfc326ef42fa001df4e5d416b445e060fda7899865',
     x86_64: '8576c36f20e83890904d3e7b19d24fb4413259f69ec97b0c9107a19d59ced9b9'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
