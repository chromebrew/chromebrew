require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "4.1.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '5d51ebfc9575ebb6a4339b96d6c1af793cee94c8d82009cf8085a1833d32e132',
     armv7l: '5d51ebfc9575ebb6a4339b96d6c1af793cee94c8d82009cf8085a1833d32e132',
       i686: '4ba9f63db36f290125c48786712feea8967b1ef0e24c3ea02682309d30e525af',
     x86_64: 'a5258c6373e3ad92e37abd2f913951e70d5b81bcc7529888724f7b7bd43e4487'
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
