require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.15.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'a30d0f7181946b4a0c6693cec61e5391392e8229bb27f9d62cc166b557890b66',
     armv7l: 'a30d0f7181946b4a0c6693cec61e5391392e8229bb27f9d62cc166b557890b66',
       i686: 'd8acbe11c8344ce003a339c5ed74edf1315ba0660f3646c91d62a18c658526cf',
     x86_64: 'd4527b6447273915a6bc210f74c3c835ca9344f7188d6898eb5c66c675fc53d8'
  })

  conflicts_ok
  gem_compile_needed
end
