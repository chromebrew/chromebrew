require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "1.8.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '19c3781c6a0ca5cf7e411ac65aad4449d981f68ec89ab437ab8c9115132d51e1',
     armv7l: '19c3781c6a0ca5cf7e411ac65aad4449d981f68ec89ab437ab8c9115132d51e1',
       i686: 'dc0013412d3b18dd1d52383412ce220b6fa5fad42805d55296908623cdb1f1f5',
     x86_64: 'f725a622f5b0f5e66d52b7f510a5a497eeeb0475c74367ef0678070436c3582e'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
