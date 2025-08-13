# Adapted from Arch Linux pyatspi PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/pyatspi/trunk/PKGBUILD

require 'buildsystems/meson'

class Py3_atspi < Meson
  description 'Python bindings for D-Bus AT-SPI'
  homepage 'http://www.linuxfoundation.org/en/AT-SPI_on_D-Bus'
  version "2.57.0-#{CREW_PY_VER}"
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/pyatspi2.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f703b5998188de9a3bbbc0a7d18980e25248ebf91d192704f1e3b1fabdccc196',
     armv7l: 'f703b5998188de9a3bbbc0a7d18980e25248ebf91d192704f1e3b1fabdccc196',
     x86_64: '1083d20bc9c59e3b4e103d237399fd4beae866f49f589b5f2eecbec03ed47c16'
  })

  depends_on 'py3_pygobject'
  depends_on 'at_spi2_core'
  depends_on 'python3' => :build
end
