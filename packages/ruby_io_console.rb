require 'buildsystems/ruby'

class Ruby_io_console < RUBY
  description 'add console capabilities to IO instances.'
  homepage 'https://github.com/ruby/io-console'
  version "0.9.3-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'dda07ec9c8f8973d159feee9bf4dc109abfe62efa100505aef63c6a01980ccfe',
     armv7l: 'dda07ec9c8f8973d159feee9bf4dc109abfe62efa100505aef63c6a01980ccfe',
       i686: '997b1e699e01bf17d5facbe8300cc265826d123513ba7472bdcf6004ea463364',
     x86_64: '55b4c1a96c4752cddc7e45aff37a94f067bdbedbd74ed5f20c19013f04756a12'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
