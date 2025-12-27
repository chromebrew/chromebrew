require 'buildsystems/ruby'

class Ruby_fiddle < RUBY
  description 'A libffi wrapper for ruby.'
  homepage 'https://github.com/ruby/fiddle'
  version "1.1.8-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'e708ffbb59e68a9d6574a1a10a6e0d5374f06c5e085e65c92d8f78f90e625b35',
     armv7l: 'e708ffbb59e68a9d6574a1a10a6e0d5374f06c5e085e65c92d8f78f90e625b35',
       i686: 'fb9ed0a9a13afdea2cf358e53cd35cc973865a820ca6fe57798254e7cbec6ecd',
     x86_64: 'a6bf9e0458ca281f659ae9969242cd32a0cf1b9458149cbcc1554a98006f1ce5'
  })

  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
