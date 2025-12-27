require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "3.10.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'd692ce442669e9d6411751e8a82bbd7768627492b19eb108dba32b695f5d1293',
     armv7l: 'd692ce442669e9d6411751e8a82bbd7768627492b19eb108dba32b695f5d1293',
       i686: '22683ba3c3cf5fb1762e7e99890156229ae66111c358f6f1b254ab5397bde2a4',
     x86_64: '0f6b02d8a33b6fe25f91c1b7d1dce7b630634dd3a68d815bfc0e787cadc6f1ba'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R
  depends_on 'ruby_abbrev' # R
  depends_on 'ruby_logger' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
