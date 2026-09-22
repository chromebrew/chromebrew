# Adapted from Arch Linux libdex PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libdex/trunk/PKGBUILD

require 'buildsystems/meson'

class Libdex < Meson
  description 'A library supporting Deferred Execution'
  homepage 'https://gitlab.gnome.org/chergert/libdex'
  version '1.2.0'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/chergert/libdex.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1760163739866c5313218f055a4e6a2484038c79edc5f2d76b5ecf7318dbfa7',
     armv7l: 'c1760163739866c5313218f055a4e6a2484038c79edc5f2d76b5ecf7318dbfa7',
     x86_64: 'dd1d89b36858f6b0e77836c759f9b67e931cc7f4ff98029cf3d42ba4f03aade8'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build

  meson_options '-Dexamples=false \
                 -Dtests=false \
                 -Dvapi=false'
end
