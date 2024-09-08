# Adapted from Arch Linux pyatspi PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/pyatspi/trunk/PKGBUILD

require 'buildsystems/autotools'

class Py3_atspi < Autotools
  description 'Python bindings for D-Bus AT-SPI'
  homepage 'https://wiki.linuxfoundation.org/accessibility/atk/at-spi/at-spi_on_d-bus'
  version '2.46.1'
  license 'GPL2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/pyatspi2.git'
  git_hashtag "PYATSPI_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  depends_on 'py3_pygobject'
  depends_on 'at_spi2_core'
  depends_on 'python3' => :build
end
