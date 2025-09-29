# Adapted from Arch Linux libdex PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libdex/trunk/PKGBUILD

require 'buildsystems/meson'

class Libdex < Meson
  description 'A library supporting Deferred Execution'
  homepage 'https://gitlab.gnome.org/chergert/libdex'
  version '1.0.0'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/chergert/libdex.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b905f8968d0cc86a71fbae8b32e8bcdf537225c86d47425f5da64a5d2631f382',
     armv7l: 'b905f8968d0cc86a71fbae8b32e8bcdf537225c86d47425f5da64a5d2631f382',
     x86_64: 'd90947586f2d7295f03a5635313c4c98cb474277fe9281a5108d054901402116'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R

  meson_options '-Dexamples=false \
                 -Dtests=false \
                 -Dvapi=false'
end
