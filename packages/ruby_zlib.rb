require 'buildsystems/ruby'

class Ruby_zlib < RUBY
  description 'Ruby interface for the zlib compression/decompression library.'
  homepage 'https://github.com/ruby/zlib'
  version "3.2.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'a58fa0c668b89f0c0135272802be6b4997d0d76181d856d7ea371b93ee9a8f1f',
     armv7l: 'a58fa0c668b89f0c0135272802be6b4997d0d76181d856d7ea371b93ee9a8f1f',
       i686: '90944dbc771b1dc1ee67824262233b4b0aa07e568f5d0ae7788719e2385a2b9b',
     x86_64: 'a40187395922eeada9adbb2bc800e9e43fd65cc39af6c8bb30871454f29b3a95'
  })

  conflicts_ok
  gem_compile_needed
end
