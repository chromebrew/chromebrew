# Adapted from Arch Linux pyatspi PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/pyatspi/trunk/PKGBUILD

require 'buildsystems/meson'

class Py3_atspi < Meson
  description 'Python bindings for D-Bus AT-SPI'
  homepage 'https://wiki.linuxfoundation.org/accessibility/atk/at-spi/at-spi_on_d-bus'
  version "2.57.0-#{CREW_PY_VER}"
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/pyatspi2.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff609e6c1461ca5596852656971b612d80061dd29426f7334ddad850821bebf3',
     armv7l: 'ff609e6c1461ca5596852656971b612d80061dd29426f7334ddad850821bebf3',
     x86_64: '35cd595bf835a8e0defa9d2839bfb3879c7543a13007ab5bd2e570745e0b0b6b'
  })

  depends_on 'py3_pygobject'
  depends_on 'at_spi2_core'
  depends_on 'python3' => :build
end
