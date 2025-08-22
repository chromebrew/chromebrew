# Adapted from Arch Linux libdecor PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libdecor/trunk/PKGBUILD

require 'buildsystems/meson'

class Libdecor < Meson
  description 'Client-side decorations library for Wayland clients'
  homepage 'https://gitlab.freedesktop.org/libdecor/libdecor'
  version '0.2.3'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/libdecor/libdecor.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4185981721be6ae817532b8a780b29c8508b7b99e9ca2946ce21bb43000ef917',
     armv7l: '4185981721be6ae817532b8a780b29c8508b7b99e9ca2946ce21bb43000ef917',
     x86_64: 'f508e2ba9eeb6285c313e5581e41e455997343822b7d00ac169b9c601a9c9d21'
  })

  depends_on 'cairo' # R
  depends_on 'dbus' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'pango' # R
  depends_on 'wayland' # R
  depends_on 'wayland_protocols' => :build

  meson_options "-Ddemo=false \
      -Dlocalstatedir=#{CREW_PREFIX}/var \
      -Dsharedstatedir=#{CREW_PREFIX}/var/lib"
end
