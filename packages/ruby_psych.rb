require 'buildsystems/ruby'

class Ruby_psych < RUBY
  description '| psych is a yaml parser and emitter.'
  homepage 'https://github.com/ruby/psych'
  version "5.2.6-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'bd3d40e6b922c5d12fe69c915d7200cd125650bf904524b6824e673fa23aaecc',
     armv7l: 'bd3d40e6b922c5d12fe69c915d7200cd125650bf904524b6824e673fa23aaecc',
       i686: 'fd9332dec71d6a9c17170a29d1b06036c00b2288b4fc64297c68fadd00b9fefd',
     x86_64: 'f968a6f7c4faac0159e7fdcc049364e03f78a841a6a53f19d56e8d8e745ba86c'
  })

  depends_on 'ruby_stringio' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
