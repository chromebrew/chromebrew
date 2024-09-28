require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "3.5.3-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'cdce5e6bc7c6ea73dc84a233862e2427db92b31c0c35ff5544c535ada0187305',
     armv7l: 'cdce5e6bc7c6ea73dc84a233862e2427db92b31c0c35ff5544c535ada0187305',
       i686: '283e2bf06396ec51438886d72b94305894278e086c274c66a29c7ba410ea05c1',
     x86_64: '7c8828fb9f1be082f75632001db85bfe5d9bd5d855fc0242bf5d0c54d112fd67'
  })

  depends_on 'ruby_abbrev' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
