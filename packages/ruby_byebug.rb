require 'buildsystems/ruby'

class Ruby_byebug < RUBY
  description 'Byebug is a Ruby debugger.'
  homepage 'https://github.com/deivid-rodriguez/byebug'
  version "12.0.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'fd35d010f2751d14adb1110ba5d84ee0748b9e8989106628f249b9d70960cdfe',
     armv7l: 'fd35d010f2751d14adb1110ba5d84ee0748b9e8989106628f249b9d70960cdfe',
       i686: 'b2ac8d2b9fd06e02767c88f46c84c87ca5a0a9428ee4b49202da2ac58c61364c',
     x86_64: 'bd98f356e56180a28a9f26aed708a382a18754fb3d3f132df927d19c0dc531ba'
  })

  conflicts_ok
  gem_compile_needed
end
