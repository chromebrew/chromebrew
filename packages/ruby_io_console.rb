require 'buildsystems/ruby'

class Ruby_io_console < RUBY
  description 'add console capabilities to IO instances.'
  homepage 'https://github.com/ruby/io-console'
  version "0.9.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'cd87659c423e36a5a3f414111f6b15781ec937abb06889da230c91448219a58e',
     armv7l: 'cd87659c423e36a5a3f414111f6b15781ec937abb06889da230c91448219a58e',
       i686: 'efabe73a6ec65377f3fee86f08a5f8176dddbff34997067212038cd3f250a714',
     x86_64: '02c3786134c63ab7f5210565c49dcca393e5a711c5b1835870d736c4e35d3961'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
