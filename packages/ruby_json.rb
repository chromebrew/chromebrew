require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.8.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'f51468aaea4dc1471c397d7b05e62422610895defb5f8805515d76c46b7cfa29',
     armv7l: 'f51468aaea4dc1471c397d7b05e62422610895defb5f8805515d76c46b7cfa29',
       i686: 'e232a0d7c4142535c9e36c09fdf6985f8b673f3fab874c7a751d31c519b117be',
     x86_64: 'c90e36d7800d7c9216f9d60d788a798e42f4fb9eaf4dc2e40c696054d0635b35'
  })

  conflicts_ok
  gem_compile_needed
end
