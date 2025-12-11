require 'buildsystems/ruby'

class Ruby_date < RUBY
  description 'A subclass of object includes comparable module for handling dates.'
  homepage 'https://github.com/ruby/date'
  version "3.5.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '28bfef4e763889bbcac15f926a0169692ec2d971ee80b6327b6d434b8ea1b6c0',
     armv7l: '28bfef4e763889bbcac15f926a0169692ec2d971ee80b6327b6d434b8ea1b6c0',
       i686: '73d25f28cba1059253346e9524feed3b25c7fbca0e620791603b5ee1db240b43',
     x86_64: 'a6afba634c7672c9fc0791c10ad84772dc93f851a878c4bd85e62743f378a33f'
  })

  conflicts_ok
  gem_compile_needed
  no_source_build
end
