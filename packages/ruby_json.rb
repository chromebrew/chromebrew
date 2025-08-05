require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.13.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'fb439eb0c07764a05805e8c1a0ef8af5d22d306e17f420a69e5a0a9ea917026b',
     armv7l: 'fb439eb0c07764a05805e8c1a0ef8af5d22d306e17f420a69e5a0a9ea917026b',
       i686: '7865e5b6f3e9a57343e1e9f1511c28bab2be784169f39427847e4faa285ea818',
     x86_64: '55c11b04e2c3490590339713a0d74381b544d48e7f84a4d68b8beb1983553314'
  })

  conflicts_ok
  gem_compile_needed
end
