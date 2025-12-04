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
    aarch64: '683cc4740e7a57ff8cb90f6a5e0118390b6fbc2e4a36b48789698f017cda9ca6',
     armv7l: '683cc4740e7a57ff8cb90f6a5e0118390b6fbc2e4a36b48789698f017cda9ca6',
       i686: '97d2f597badbf562c3ff32a65810e9fcf595b38d5c0fd91d0ad0f6b14c65f7d1',
     x86_64: 'cb755def51f336a2f37884308864e7effd3156cd1d974eebbeaab59cfecc9f7f'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
