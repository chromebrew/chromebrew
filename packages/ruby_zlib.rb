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
     x86_64: 'b815f4c3ff6f5490fcd715dec38db2e9141a3c69d7d8d2138ef28673f261f617'
  })

  conflicts_ok
  gem_compile_needed
end
