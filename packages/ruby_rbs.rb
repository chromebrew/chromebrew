require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "4.1.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '8dad08b3a04224776b637a190cf422977c0e5025105723b844d2e78360fb20b2',
     armv7l: '8dad08b3a04224776b637a190cf422977c0e5025105723b844d2e78360fb20b2',
       i686: 'b85eff5f7ed7fdf548e226cd8c5212e081976a6af1958e09d643e7d7101ed37c',
     x86_64: 'a0b82656fe95d1ad9d8b1f4b97b949b79100db2bf0bbf84b20d38abdbc9141cc'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library
  depends_on 'ruby_logger' # R
  depends_on 'ruby_tsort' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
