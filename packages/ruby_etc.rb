require 'buildsystems/ruby'

class Ruby_etc < RUBY
  description 'Provides access to information typically stored in unix /etc directory.'
  homepage 'https://github.com/ruby/etc'
  version "1.4.6-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '7c342cd0ce5fed8b3909017ca419cfb2b2baff20e8d2ccd81230715ab86f3f15',
     armv7l: '7c342cd0ce5fed8b3909017ca419cfb2b2baff20e8d2ccd81230715ab86f3f15',
       i686: '4a4a2c7c4c9e175640df60d83d337cbd63f023e35f900293a2b23f93867643a1',
     x86_64: '2e6018c01f20bd1797f585716019533ded413b551ad713325d8d43fcc2daed4d'
  })

  conflicts_ok
  gem_compile_needed
end
