# Adapted from Arch Linux libdecor PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libdecor/trunk/PKGBUILD

require 'buildsystems/meson'

class Libdecor < Meson
  description 'Client-side decorations library for Wayland clients'
  homepage 'https://gitlab.freedesktop.org/libdecor/libdecor'
  version '0.2.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/libdecor/libdecor.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26ba96e32ae7e00488aaf8f11e23b779ef8e747c37848e26965382ba84b8f81c',
     armv7l: '26ba96e32ae7e00488aaf8f11e23b779ef8e747c37848e26965382ba84b8f81c',
     x86_64: '3f77be8ebdfd6548f434e9f9ed13a365cc5956d413cb83f15714aaf0bb27214e'
  })

  depends_on 'cairo' # R
  depends_on 'dbus' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'pango' # R
  depends_on 'wayland_protocols' => :build
  depends_on 'wayland' # R

  meson_options "-Ddemo=false \
      -Dlocalstatedir=#{CREW_PREFIX}/var \
      -Dsharedstatedir=#{CREW_PREFIX}/var/lib"
end
