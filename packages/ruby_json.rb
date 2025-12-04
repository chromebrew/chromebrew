require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.17.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'd5a301278d8990b07099a296ee36661095dd247d77a9ef89b4e333e5d0ac0dc1',
     armv7l: 'd5a301278d8990b07099a296ee36661095dd247d77a9ef89b4e333e5d0ac0dc1',
       i686: '0a8e2074d2debc2f4760a2c739a52e2f9e9dd653fd67e3b546037ec24d65710d',
     x86_64: '80cb89176adcbb51f959cf23adc159dbfd5f84b700208a01eafa87a340a6d843'
  })

  conflicts_ok
  gem_compile_needed
end
