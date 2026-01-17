# Adapted from Arch Linux pyatspi PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/pyatspi/trunk/PKGBUILD

require 'buildsystems/meson'

class Py3_atspi < Meson
  description 'Python bindings for D-Bus AT-SPI'
  homepage 'https://wiki.linuxfoundation.org/accessibility/atk/at-spi/at-spi_on_d-bus'
  version "2.58.1-#{CREW_PY_VER}"
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/pyatspi2.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '376b56728f9cee9facd388f039033b9ba0f18dc2dc64992d0db74971404f9a58',
     armv7l: '376b56728f9cee9facd388f039033b9ba0f18dc2dc64992d0db74971404f9a58',
     x86_64: '046fdfcb54a129af899bb6f8083af3c5f6c98de75aa4fced5a49f53e1fa0c101'
  })

  depends_on 'py3_pygobject'
  depends_on 'at_spi2_core'
  depends_on 'python3' => :build
end
