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

  depends_on 'glib'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
