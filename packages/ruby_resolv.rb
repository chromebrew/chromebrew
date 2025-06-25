require 'buildsystems/ruby'

class Ruby_resolv < RUBY
  description 'Thread-aware dns resolver library in ruby.'
  homepage 'https://github.com/ruby/resolv'
  version "0.6.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'ce2ddf54e80e8f1a5e6a5622597a6a431640536b6dda39880cfe641d5cd4465d',
     armv7l: 'ce2ddf54e80e8f1a5e6a5622597a6a431640536b6dda39880cfe641d5cd4465d',
       i686: '1ea007a73c93e6166898dd4b790723ed448c0497f8d3bf306d98039f95aa4214',
     x86_64: '1925a07fc0a51f19dbf696da1e8e8e1dd360a8dbdf6a2771b5c4c3551dce1fd1'
  })

  conflicts_ok
  gem_compile_needed
end
