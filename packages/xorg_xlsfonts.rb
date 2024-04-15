# Adapted from Arch Linux xorg-xlsfonts PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/xorg-xlsfonts/trunk/PKGBUILD

require 'package'

class Xorg_xlsfonts < Package
  description 'List available X fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.7'
  license 'X11'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://xorg.freedesktop.org/archive/individual/app/xlsfonts-1.0.7.tar.xz'
  source_sha256 '7b726945a967b44c35cddee5edd74802907a239ce2e2e515730b8a32c8e50465'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a86a0ffa9e86dee2df9711303b9b3464773af0684b912e3487cf361de854ccea',
     armv7l: 'a86a0ffa9e86dee2df9711303b9b3464773af0684b912e3487cf361de854ccea',
     x86_64: 'cc8c7063814815f5752fc70ad12b61dc5891db6b2c0196eea937dde69096d9c5'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'util_macros' => ':build'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
