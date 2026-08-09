require 'buildsystems/meson'

class Radare2 < Meson
  description 'unix-like reverse engineering framework and commandline tools'
  homepage 'https://www.radare.org/r/'
  version '6.2.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/radare/radare2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '443e5d1fbd6d26bb818ccb658d69cf751285b3d041e1e8dfc45001aba32e3496',
     armv7l: '443e5d1fbd6d26bb818ccb658d69cf751285b3d041e1e8dfc45001aba32e3496',
       i686: 'b64ffed46d19be6ca2e62f48f44f9ef3df5d87cad70410aba50eea40c4555148',
     x86_64: 'c212c054be01c4d336e870fc4a738010d60bc4529f324606383e685cfb61494c'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl'

  meson_options '-Duse_sys_openssl=true'
end
