require 'buildsystems/cmake'

class Oorexx < CMake
  description 'Free implementation of Object Rexx'
  homepage 'https://www.oorexx.org/'
  version '5.1.0-12905'
  license 'CPL-v1.0'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/oorexx/oorexx/5.1.0beta/oorexx-5.1.0-12905.tar.gz'
  source_sha256 'e69a6d18f49c5097d8cdec628be2c838b890310ca617587630f532349871ea21'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '359087ff1dc22fe406855a02848a63c2e7c8807abe36531cb5123ea5af3dec25',
     armv7l: '359087ff1dc22fe406855a02848a63c2e7c8807abe36531cb5123ea5af3dec25',
       i686: '437664b88aef6a1272d12f38918e6718b39c06a82a63afb17d43db1a0e223825',
     x86_64: 'f7a6da2c80d58800e66fb0c2c35e446165370b66c1fd9e472cf9abb9a3507fd5'
  })

  depends_on 'ncurses'
  depends_on 'subversion' => :build
end
