require 'buildsystems/ruby'

class Ruby_etc < RUBY
  description 'Provides access to information typically stored in unix /etc directory.'
  homepage 'https://github.com/ruby/etc'
  version "1.4.4-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '896c7745514e3b45b4ff9c6a20f0f14197d6ca4efc48fc8ba80bc81bc754f5b6',
     armv7l: '896c7745514e3b45b4ff9c6a20f0f14197d6ca4efc48fc8ba80bc81bc754f5b6',
     x86_64: '69e46a65066e7e277687a99439c2b5664280b5c56518105757ac9919b2b6d016'
  })

  conflicts_ok
  gem_compile_needed
end
