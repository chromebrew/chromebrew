require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version '1.18.0-2'
  compatibility 'all'
  source_url 'https://wayland.freedesktop.org/releases/wayland-1.18.0.tar.xz'
  source_sha256 '4675a79f091020817a98fd0484e7208c8762242266967f55a67776936c2e294d'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.18.0-2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.18.0-2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.18.0-2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.18.0-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'f5686b065f2395724aadbd5c27d953aa9a93035f35fd71b315fcddf96c89507a',
      armv7l: 'f5686b065f2395724aadbd5c27d953aa9a93035f35fd71b315fcddf96c89507a',
        i686: '1abcde23427ad7fffc9773cca1695790ec08e7a0ee2b98c4601f395a808acac4',
      x86_64: '41abcb4d0bf10e5b09b8cecdcfe8685379d91b07e541ed54654477c8fbb807fb',
  })

  depends_on 'expat'
  depends_on 'libpng'
  depends_on 'libffi'
  depends_on 'libxml2'
  depends_on 'libxslt'
  #depends_on 'xmlto' => :build
  #depends_on 'docbook_xsl' => :build
  #depends_on 'graphviz' => :build # GraphViz doesn't have PNG support enabled

  def self.build
    system "./configure \
            #{CREW_OPTIONS} \
            --disable-documentation"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system 'libtool', '--finish', CREW_LIB_PREFIX
  end
end
