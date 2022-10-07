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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_atspi/2.46.0_armv7l/py3_atspi-2.46.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_atspi/2.46.0_armv7l/py3_atspi-2.46.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_atspi/2.46.0_i686/py3_atspi-2.46.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_atspi/2.46.0_x86_64/py3_atspi-2.46.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'db93f6d178f997e3dd9db88dca25e08f4b81f108c335a0469ac4ea8746e2fd34',
     armv7l: 'db93f6d178f997e3dd9db88dca25e08f4b81f108c335a0469ac4ea8746e2fd34',
       i686: 'f474a6b122a29c8c5c6747d4734c871b9455506db702041cb6a7cde5dfe5e1c6',
     x86_64: '9d8c292cd5f060c08d3af5b4ae4a7535bd1777dfd085bd67637f6437691249c9'
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
