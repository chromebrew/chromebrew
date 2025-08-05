require 'buildsystems/ruby'

class Ruby_etc < RUBY
  description 'Provides access to information typically stored in unix /etc directory.'
  homepage 'https://github.com/ruby/etc'
  version "1.4.6-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '024c05673730fc7daf911de1d6e55c6f356f5b117624bbc7c1518e5e94dbb43c',
     armv7l: '024c05673730fc7daf911de1d6e55c6f356f5b117624bbc7c1518e5e94dbb43c',
       i686: '4d3ad83bec00f97af032b3fed1bf48f3bd6ba42db564a2fa7bf0f33267c441c5',
     x86_64: 'd26b0e71c5acff7122cf438fe0031b510c40e834195a4d88cd72817653ed4100'
  })

  conflicts_ok
  gem_compile_needed
end
