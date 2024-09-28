require 'buildsystems/ruby'

class Ruby_racc < RUBY
  description 'Racc is a LALR(1) parser generator.'
  homepage 'https://github.com/ruby/racc'
  version "1.8.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '58f574de45e03714cb7a8d106f75eb748ed4e058eb32918ab8af6e4bb73d6978',
     armv7l: '58f574de45e03714cb7a8d106f75eb748ed4e058eb32918ab8af6e4bb73d6978',
       i686: 'e3a436a103ff7f3654829f44485c335f8662d4f28ff1595e11d68367f4152a4c',
     x86_64: '4aeda24a163aad7f64c91a3adfeaf38f9f0c5e5570216dcc3e8c6943a3eb727a'
  })

  conflicts_ok
  gem_compile_needed
end
