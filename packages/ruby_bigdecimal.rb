require 'buildsystems/ruby'

class Ruby_bigdecimal < RUBY
  description 'This library provides arbitrary-precision decimal floating-point number class.'
  homepage 'https://github.com/ruby/bigdecimal'
  version "3.2.3-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '9c889a779a5f52e8f761437e81fc4f75523e73534f3275afea1363c26c8129c2',
     armv7l: '9c889a779a5f52e8f761437e81fc4f75523e73534f3275afea1363c26c8129c2',
       i686: '1532c0303ecca62826b2f646039caf6dfb1c46670865af0f3586e777143d6691',
     x86_64: '30fb88ec52f260c546310f35bbcdbf1c725b5c1f46060cbae15b71e3f5e87b5d'
  })

  conflicts_ok
  gem_compile_needed
end
