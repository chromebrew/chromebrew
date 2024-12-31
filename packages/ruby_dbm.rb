require 'buildsystems/ruby'

class Ruby_dbm < RUBY
  description 'Provides a wrapper for the UNIX-style Database Manager Library.'
  homepage 'https://github.com/ruby/dbm'
  version "1.1.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'fd9835fe70bd21049a79b6c72f1b1aecd0bdb9e9f287317d7ac1e5d84e6445fb',
     armv7l: 'fd9835fe70bd21049a79b6c72f1b1aecd0bdb9e9f287317d7ac1e5d84e6445fb',
       i686: 'eb9258697d79caa82143f9e61ea51d522c1c2341e524fdcda99674cedeed9be0',
     x86_64: 'b21fb3132169637c38e1bae6c011e99b318f69a66e7d2826cb9a5da992933de3'
  })

  conflicts_ok
  gem_compile_needed
end
