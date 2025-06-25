require 'buildsystems/ruby'

class Ruby_debug < RUBY
  description 'The debug library provides debugging functionality to Ruby (MRI) 2.7 and later.'
  homepage 'https://github.com/ruby/debug'
  version "1.11.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '7a1efdf95437021b37d11070c5b8d8233c23a15734435164795458867dfbd712',
     armv7l: '7a1efdf95437021b37d11070c5b8d8233c23a15734435164795458867dfbd712',
       i686: 'ccf6c9a901804bcc1618a5e8a69c34f68c024fc9f5dd3fcbe9864035d30d4d3f',
     x86_64: '9f2af2b749e8f4284d768387a6bb711400854e3bc46e1c92ecb2e3d44f95e277'
  })

  depends_on 'ruby_reline' # R

  depends_on 'ruby_irb' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
