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
       i686: '840ce5ea587b975310568ff07592e46104291654cb46a62550e3114a770896c3',
     x86_64: '5f3f544c343bcee028d5a9393205bb0c9b1b95eb730627496cd2412f203a9f4a'
  })

  conflicts_ok
  gem_compile_needed
end
