require 'buildsystems/ruby'

class Ruby_bigdecimal < RUBY
  description 'This library provides arbitrary-precision decimal floating-point number class.'
  homepage 'https://github.com/ruby/bigdecimal'
  version "4.1.3-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'fb0252c64a7077bd6b7edebd7f2c54aabe918e5829a62e726e5c29310c38d31c',
     armv7l: 'fb0252c64a7077bd6b7edebd7f2c54aabe918e5829a62e726e5c29310c38d31c',
       i686: '45488ef4a26b6d2039f77cbd31d601cb5bf0a17d331d5ece5f5e3e8be201b8a9',
     x86_64: ''
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
