require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.14.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '77a265fcd89bfd61da99ef2dfa47408c2dc100da667a048723b4e8901de1787a',
     armv7l: '77a265fcd89bfd61da99ef2dfa47408c2dc100da667a048723b4e8901de1787a',
       i686: 'e6f0ff648c14a50f690f5d7442112decf9e25aa4d9bfcbd89a1e8a3a68a75cbf',
     x86_64: '86e9f286d297a3dce89847272d2c3ccd35e06727cf3bfc68992dc45a60cd140c'
  })

  conflicts_ok
  gem_compile_needed
end
