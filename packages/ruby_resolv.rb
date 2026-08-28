require 'buildsystems/ruby'

class Ruby_resolv < RUBY
  description 'Thread-aware dns resolver library in ruby.'
  homepage 'https://github.com/ruby/resolv'
  version "0.7.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'fa4878bf495b2a80503023289e7a7f58321e33029ad6858af6ea6325628308fa',
     armv7l: 'fa4878bf495b2a80503023289e7a7f58321e33029ad6858af6ea6325628308fa',
       i686: '612711ca7a91dae5f8762b9f0de5ad4e21486f2d4e2e788cb1ccb8809593403b',
     x86_64: 'acfc2b4eaea83ad7696a36149ebca9842c0f1a437999eda1cb7a4d0bbd02e798'
  })

  depends_on 'ruby' => :logical

  conflicts_ok
  gem_compile_needed
end
