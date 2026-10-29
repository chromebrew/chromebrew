require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "2.1.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '366b19d3e41edddebc25a912e8941bda81dc4e52181b9a196dd894719a87bd43',
     armv7l: '366b19d3e41edddebc25a912e8941bda81dc4e52181b9a196dd894719a87bd43',
       i686: 'bbbf5293a346abdaa152c921f436ec6258bf17cbd409158510d36541e259e673',
     x86_64: '88c2d7e5105e11f403828d955de3c2cde0b5f3da37601ac222bccd54ea72d1af'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
