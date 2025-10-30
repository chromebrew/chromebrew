# Adapted from Arch Linux libdecor PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libdecor/trunk/PKGBUILD

require 'buildsystems/meson'

class Libdecor < Meson
  description 'Client-side decorations library for Wayland clients'
  homepage 'https://gitlab.freedesktop.org/libdecor/libdecor'
  version '0.2.4'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/libdecor/libdecor.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a827ae756d375ee4931aabea46f2032824d87c50b1b98aa0404ddbbf61ce4e9d',
     armv7l: 'a827ae756d375ee4931aabea46f2032824d87c50b1b98aa0404ddbbf61ce4e9d',
     x86_64: 'b1357bac979ec34bedf9ef48d3648d6703498225ab2049bffac70b72a2e3cc0a'
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
