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
    aarch64: 'd3b60abec7054815d102eacbd6b575b17cb0e27c6fd72221af17e20be235f390',
     armv7l: 'd3b60abec7054815d102eacbd6b575b17cb0e27c6fd72221af17e20be235f390',
       i686: 'aea9f84ce0555113033d0248c4ba5f942e62a2d37d72f2288fec583d055a2914',
     x86_64: 'f2a51c6e0a68bf936b84097cd3b7b0c5a111fd78dcf5c3cc43040c15610b5865'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
