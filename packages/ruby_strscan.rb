require 'buildsystems/ruby'

class Ruby_strscan < RUBY
  description 'Provides lexical scanning operations on a String.'
  homepage 'https://github.com/ruby/strscan'
  version "3.1.8-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '0f4ea9a77009883f2fb787dc17a2c75d8aed059222c369f28bc16203c8f170d9',
     armv7l: '0f4ea9a77009883f2fb787dc17a2c75d8aed059222c369f28bc16203c8f170d9',
       i686: '51a8ab4e5f7c3f024f33c070ab77ca91526a87035ceedcd1ab7dfb12c44d8388',
     x86_64: '7a2e6792515f9825bd91f1874a0953950af32398dce49053fc0bbeb38d13e6c0'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
  no_source_build
end
