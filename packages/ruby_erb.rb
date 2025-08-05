require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "5.0.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'a04f71d60f08fdaa5e8e9684c80fc1076477934e7f84992ab0818b9e23cae064',
     armv7l: 'a04f71d60f08fdaa5e8e9684c80fc1076477934e7f84992ab0818b9e23cae064',
       i686: 'e61fb795d13f5277120da061476e5614d7707adc4bad3e503374333466e34f84',
     x86_64: '4304014ffafb0b127e6b5fd89c74f945aecd63143bc63a8c168c63a0d0611eac'
  })

  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
