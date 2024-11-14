require 'buildsystems/ruby'

class Ruby_syslog < RUBY
  description 'Ruby interface for the posix system logging facility.'
  homepage 'https://github.com/ruby/syslog'
  version "0.1.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'fc77ea7296e23557fbcf60c4d6330505130c64b8abf73df9d1aee97b9de0dd8d',
     armv7l: 'fc77ea7296e23557fbcf60c4d6330505130c64b8abf73df9d1aee97b9de0dd8d',
       i686: '6ef29336b29f7af269568514ac0b37b4030fc81e6df8c76f40da485f9d8f372b',
     x86_64: 'ef27e07ef618b81865de5c5146330eb9c9e95a44245b0838a8c93769a498a611'
  })

  conflicts_ok
  gem_compile_needed
end
