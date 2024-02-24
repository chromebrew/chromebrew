# Adapted from Arch Linux libslirp PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libslirp/trunk/PKGBUILD

require 'buildsystems/meson'

class Libslirp < Meson
  description 'General purpose TCP-IP emulator'
  homepage 'https://gitlab.freedesktop.org/slirp/libslirp'
  version '4.7.0'
  license 'BSD MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/slirp/libslirp.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '60e4b6b8f317dc288d85a36ed194d2211417446457fbab174ef84b76423d7047',
     armv7l: '60e4b6b8f317dc288d85a36ed194d2211417446457fbab174ef84b76423d7047',
       i686: '427a983deb897340d2ec30570efedb6d9c2072da5125f25ead6e63b11da67a1f',
     x86_64: 'bcfe4319c8f6902437cddc15a1dd96c0003dea68f754acad0a0160f499956ec7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
end
