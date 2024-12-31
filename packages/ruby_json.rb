require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.9.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'a4c3d6ad62657a4edc82911981dd617b8f270e76b160f59d6f590aee86b26d5c',
     armv7l: 'a4c3d6ad62657a4edc82911981dd617b8f270e76b160f59d6f590aee86b26d5c',
       i686: '77891fdaaf2316852adeaa293e5a072eecd5eaa4c8281e1a56053746e5ad3689',
     x86_64: '2a67638b26f450166d3d26dc01a57b7bff3fe1010fbc0af714e56192f77a3cfa'
  })

  conflicts_ok
  gem_compile_needed
end
