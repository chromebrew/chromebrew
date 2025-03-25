require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "3.9.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'bf2accc06c666e75e5716ae0f75f24c5a53a56747e220b3ef19f4d72bbcf80c5',
     armv7l: 'bf2accc06c666e75e5716ae0f75f24c5a53a56747e220b3ef19f4d72bbcf80c5',
       i686: '9a7ab8519738f6a7fe29db44e7e603d4964301f5e6e6035a8d1a87765b79c3f2',
     x86_64: '7077bedc857b319806b495cf0d0fc66cdb23dd234a6a441806a3bc5a92bfacab'
  })

  depends_on 'ruby_abbrev' # R
  depends_on 'ruby_logger' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
