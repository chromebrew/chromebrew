require 'buildsystems/meson'

class Radare2 < Meson
  description 'unix-like reverse engineering framework and commandline tools'
  homepage 'https://www.radare.org/r/'
  version '6.2.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/radare/radare2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '028cf7e3dce5c4df32c6c8c54a22c97a6ca54c79f12b25292595451cbd47b67c',
     armv7l: '028cf7e3dce5c4df32c6c8c54a22c97a6ca54c79f12b25292595451cbd47b67c',
       i686: '9d5972efcc27425e8178d5c159700f28a717db5becb59f699aeb536b0024b06d',
     x86_64: '78aec6fbfe0ae999bf2b1141c926654f77df5340f0f11a0966ff95f75483142b'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl'

  meson_options '-Duse_sys_openssl=true'
end
