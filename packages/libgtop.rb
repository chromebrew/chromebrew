# Adapted from Arch Linux libgtop PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libgtop/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libgtop < Autotools
  description 'A library for collecting system monitoring data'
  homepage 'https://gitlab.gnome.org/GNOME/libgtop'
  version '2.40.0-507809b'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libgtop.git'
  git_hashtag '507809b648634c6251e9aeeb8ffae1d38c5be5f7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '162e38569618da3e070b43c13efb2a097ca66e4e1bc2b22cfc81f8c64166332f',
     armv7l: '162e38569618da3e070b43c13efb2a097ca66e4e1bc2b22cfc81f8c64166332f',
       i686: '7b37bd68ff372e474fabdce60b6b635e69291b7d6866457c268aa053ecb207da',
     x86_64: '259446e4819d162fd7963535ae7a52ba2bc868e4b8939fe00dc27baf54e69a23'
  })

  depends_on 'libxau' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R

  gnome
end
