require 'buildsystems/ruby'

class Ruby_fiddle < RUBY
  description 'A libffi wrapper for ruby.'
  homepage 'https://github.com/ruby/fiddle'
  version "1.1.7-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'adabccd39e60519d5e841bb944f9b1901706d6f6a0ff96d652c9b45e88bc3db0',
     armv7l: 'adabccd39e60519d5e841bb944f9b1901706d6f6a0ff96d652c9b45e88bc3db0',
       i686: 'f9fcc22e3efc5f42a821b46f12ec5a6824ec0871e63c76da65f28808cf7df4bc',
     x86_64: '53945142f943d053fb5bb16b26fb2475609ba946c008d0bf7e79b07ee65c1bf8'
  })

  conflicts_ok
  gem_compile_needed
end
