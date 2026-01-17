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
    aarch64: 'a65c5150d7d6f45ac2f102f54ca1eff89a1ffed11d824c39e24d173453d1ea72',
     armv7l: 'a65c5150d7d6f45ac2f102f54ca1eff89a1ffed11d824c39e24d173453d1ea72',
     x86_64: '7aabdd98b92bf7aa7dc93a727f01b7bed5af96ecad2bbdac96061cb519fb2025'
  })

  depends_on 'py3_pygobject'
  depends_on 'at_spi2_core'
  depends_on 'python3' => :build
end
