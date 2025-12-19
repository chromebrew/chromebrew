require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "1.7.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '159d6d17ef53eb244c1daecbcafd890f06f098cd24367072cc15018356a07995',
     armv7l: '159d6d17ef53eb244c1daecbcafd890f06f098cd24367072cc15018356a07995',
       i686: '57c23ccc2117b30afa8f60af695eaa31316a53bbd82c157e7c4d89daa0e1af74',
     x86_64: 'e13ba7e2855678a0f3ea48bb0d949d9f5a02f6ca9d8f819c69630a1603411117'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
