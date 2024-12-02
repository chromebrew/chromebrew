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
    aarch64: '0bcc0c224da1c562d2aff0767107213c3b628890f41b39211fff9ffd30ebe8ad',
     armv7l: '0bcc0c224da1c562d2aff0767107213c3b628890f41b39211fff9ffd30ebe8ad',
       i686: '8ce54235b4546c4fbc6a12cc8df76642fcc43543d397ea2317e3c8ddbb743b58',
     x86_64: 'a40187395922eeada9adbb2bc800e9e43fd65cc39af6c8bb30871454f29b3a95'
  })

  conflicts_ok
  gem_compile_needed
end
