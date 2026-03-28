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
    aarch64: '80eae8f93cb36080c358568ef42e8f70e7ed816b32af6861bbdfd8facca3289f',
     armv7l: '80eae8f93cb36080c358568ef42e8f70e7ed816b32af6861bbdfd8facca3289f',
     x86_64: '961001ee5172ebbd4c753989422a6ed0204255ba85501cedfedfc8c2a980b5ba'
  })

  depends_on 'py3_pygobject'
  depends_on 'at_spi2_core'
  depends_on 'python3' => :build
end
