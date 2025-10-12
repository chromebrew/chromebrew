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
    aarch64: '01c36b3188d1573ec08839604eff1063cede9040340fc1d74877f23d767519a0',
     armv7l: '01c36b3188d1573ec08839604eff1063cede9040340fc1d74877f23d767519a0',
       i686: '03005c3ce979ef4bcfe7c383dcdb9301cbb22acebdcd44b674df05db92d08e74',
     x86_64: '8eb4c8b37e4bd22894726922d633b3e38d424a6bd85d8cccf037ab2d330fe380'
  })

  conflicts_ok
  gem_compile_needed
end
