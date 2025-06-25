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
    aarch64: '05f7c1b496933738df9137d832add02f3dc410ccef7aa0a791556cc92104e9d5',
     armv7l: '05f7c1b496933738df9137d832add02f3dc410ccef7aa0a791556cc92104e9d5',
       i686: '840ce5ea587b975310568ff07592e46104291654cb46a62550e3114a770896c3',
     x86_64: '5f3f544c343bcee028d5a9393205bb0c9b1b95eb730627496cd2412f203a9f4a'
  })

  conflicts_ok
  gem_compile_needed
end
