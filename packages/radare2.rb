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
    aarch64: 'b46ceec491a2b32a372cb034a7ee4812b7c3b40ee3dbd8984cd53e2b19e9bd12',
     armv7l: 'b46ceec491a2b32a372cb034a7ee4812b7c3b40ee3dbd8984cd53e2b19e9bd12',
       i686: '90f2837a01972bc9dd836a3a25e9e560bd253dde99c0785767f9a3401a10b2dc',
     x86_64: 'f50cf8b0e6a4449b5590dfa79109267565a4670d69f434a4350eff68cec1b4be'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl'

  meson_options '-Duse_sys_openssl=true'
end
