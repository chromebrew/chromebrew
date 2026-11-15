# Adapted from Arch Linux pyatspi PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/pyatspi/trunk/PKGBUILD

require 'buildsystems/meson'

class Py3_atspi < Meson
  description 'Python bindings for D-Bus AT-SPI'
  homepage 'https://wiki.linuxfoundation.org/accessibility/atk/at-spi/at-spi_on_d-bus'
  version "2.58.2-#{CREW_PY_VER}"
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/pyatspi2.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c7ad1f3e2c3e00684426ebb47552c08e0dfc302fea04d7e0bec7eb87af7ef3b5',
     armv7l: 'c7ad1f3e2c3e00684426ebb47552c08e0dfc302fea04d7e0bec7eb87af7ef3b5',
     x86_64: '854941ed9f9261aa8e878b9504933d16752b0e8227f408bd2f1572d2010a1c13'
  })

  depends_on 'at_spi2_core'
  depends_on 'py3_pygobject'
  depends_on 'python3' => :logical
end
