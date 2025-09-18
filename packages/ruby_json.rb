require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.14.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '77a265fcd89bfd61da99ef2dfa47408c2dc100da667a048723b4e8901de1787a',
     armv7l: '77a265fcd89bfd61da99ef2dfa47408c2dc100da667a048723b4e8901de1787a',
       i686: '66612861f8218ae58bdf6180f45f9d6c00e494f77217124d84b90aba5cef8d2a',
     x86_64: '86e9f286d297a3dce89847272d2c3ccd35e06727cf3bfc68992dc45a60cd140c'
  })

  conflicts_ok
  gem_compile_needed
end
