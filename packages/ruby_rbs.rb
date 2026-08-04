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
    aarch64: '2854eabad8ddb4046b014f05034829e5f5c59321c8701d46b125b09de54cd574',
     armv7l: '2854eabad8ddb4046b014f05034829e5f5c59321c8701d46b125b09de54cd574',
       i686: '7774b9aa74afaa9524c697366836daa5453817b195b50551e9bf1c95a5577e29',
     x86_64: '6d3f75d7a8f2a51d619852cafee32f13fc67106a0b8b2720d2b7c481635900c6'
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
