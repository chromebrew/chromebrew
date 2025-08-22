# Adapted from Arch Linux libslirp PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libslirp/trunk/PKGBUILD

require 'buildsystems/meson'

class Libslirp < Meson
  description 'General purpose TCP-IP emulator'
  homepage 'https://gitlab.freedesktop.org/slirp/libslirp'
  version '4.9.1'
  license 'BSD MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/slirp/libslirp.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4fa63df77df7cd28b9a39a7f3219eb00a2e22fbd04f2c3c92c593f3d4d47b41b',
     armv7l: '4fa63df77df7cd28b9a39a7f3219eb00a2e22fbd04f2c3c92c593f3d4d47b41b',
       i686: '17441583d015269d2da5cc721623f004d69865f7295db8bf295f91b25c18387f',
     x86_64: '5e6e736210fd46a2f676b03d5fbd66c6ce2aba651ac09cf4191e92b2f989c220'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
end
