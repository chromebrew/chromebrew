# Adapted from Arch Linux pyatspi PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/pyatspi/trunk/PKGBUILD

require 'package'

class Py3_atspi < Package
  description 'Python bindings for D-Bus AT-SPI'
  homepage 'https://wiki.linuxfoundation.org/accessibility/atk/at-spi/at-spi_on_d-bus'
  version '2.46.0'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pyatspi2.git'
  git_hashtag "PYATSPI_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_atspi/2.46.0_armv7l/py3_atspi-2.46.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_atspi/2.46.0_armv7l/py3_atspi-2.46.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_atspi/2.46.0_i686/py3_atspi-2.46.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_atspi/2.46.0_x86_64/py3_atspi-2.46.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fbe377c1252ee7c0660a0056fcbb0d3dd810dfc1f78fc98046048f10c00d4c75',
     armv7l: 'fbe377c1252ee7c0660a0056fcbb0d3dd810dfc1f78fc98046048f10c00d4c75',
       i686: '4edf9a96a0143e3125f9ea74c8a38295033bef9fa2b9b7393b6cb1875c8caf94',
     x86_64: 'd055212318d6d767727c4ef4b8ce3c8e2e9ebf753136b22d1e4bb0200b66985e'
  })

  depends_on 'pygobject'
  depends_on 'at_spi2_core'
  depends_on 'python3' => :build

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
