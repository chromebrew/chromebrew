require 'package'

class Eudev < Package
  description 'Gentoo standalone udev'
  homepage 'https://wiki.gentoo.org/wiki/Project:Eudev'
  version '3.2.5'
  source_url 'https://github.com/gentoo/eudev/archive/v3.2.5.tar.gz'
  source_sha256 '870920011285b919fca5c60eaa5670312eeffe3883dd8cf564cd1179fc639336'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/eudev-3.2.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/eudev-3.2.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/eudev-3.2.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/eudev-3.2.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd2fbb41ecb2390becd39b254b439df728c2f5367c1c358e3d2a8a036f4ec8b9e',
     armv7l: 'd2fbb41ecb2390becd39b254b439df728c2f5367c1c358e3d2a8a036f4ec8b9e',
       i686: '534d53bf5d4e87142225f7a30df6c725fe3fba070424a8dca0d78fa322d6ecbc',
     x86_64: '5e3e4854c0e4aafba159a0c118e8cdaf362715e1528944e46ece4d93146e0fc0',
  })

  depends_on 'libxslt'
  depends_on 'libtool'
  depends_on 'gperf'
  depends_on 'automake' => :build
  depends_on 'util_linux' => :build

  def self.build
    system 'autoreconf -f -i -s'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
