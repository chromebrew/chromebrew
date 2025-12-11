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
    aarch64: '752608d959678d7e1bd29cedcd27334ca6117549dfb6b619cd308f8da2e51e11',
     armv7l: '752608d959678d7e1bd29cedcd27334ca6117549dfb6b619cd308f8da2e51e11',
       i686: '7b8b6292ff2e820c183c4f63444c78b0956de2e3c91e0fdeb6775e967d5e593b',
     x86_64: '965ca7ef726f62c1b8e09406e09d8544c9f474199dded177709ac8c578509bdb'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
