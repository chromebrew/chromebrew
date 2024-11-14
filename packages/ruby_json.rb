require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.7.5-java-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '4c9e47bfbc416ab2ba5c1188994ec401dc93a82e507a447eafc85fd4306df536',
     armv7l: '4c9e47bfbc416ab2ba5c1188994ec401dc93a82e507a447eafc85fd4306df536',
       i686: '10e60f9904165a8ee7138da3d2ad257705942266f760c1e78a5247040f6c8295',
     x86_64: 'be9d7a39cbd96e4df5ba2f64db72a3a468d29580898ad37c2cd4000fd849f88d'
  })

  conflicts_ok
  gem_compile_needed
end
