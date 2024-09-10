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

  binary_sha256({
    aarch64: '6a9dc1b83de4643e80e8927dc119cc969bcf4d14c9a99b2d35ef89ef5c49142a',
     armv7l: '6a9dc1b83de4643e80e8927dc119cc969bcf4d14c9a99b2d35ef89ef5c49142a',
     x86_64: '7105f68498920cdfdc304eff17005384cf4d6f13f6bf744b2a5db6d1059b90c8'
  })

  depends_on 'py3_pygobject'
  depends_on 'at_spi2_core'
  depends_on 'python3' => :build
end
