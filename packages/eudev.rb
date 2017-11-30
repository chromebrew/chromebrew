require 'package'

class Eudev < Package
  description 'Gentoo standalone udev'
  homepage 'https://wiki.gentoo.org/wiki/Project:Eudev'
  version '3.2.4'
  source_url 'https://github.com/gentoo/eudev/archive/v3.2.4.tar.gz'
  source_sha256 'a68871be55aecb977ae4a206b5ce5a868a722e025f37387d1a702a409933bbeb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/eudev-3.2.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/eudev-3.2.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/eudev-3.2.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/eudev-3.2.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0193dd693fbba3f49e792b1890f3060f186fd12e3544786451ed9527c7fec3b7',
     armv7l: '0193dd693fbba3f49e792b1890f3060f186fd12e3544786451ed9527c7fec3b7',
       i686: 'c372115b1f1b4369a669f7df22d0b7b2d24591c1e45826e60c5e0e6f549e301f',
     x86_64: 'eee2bc39b9ad1dcf8bd3db079dcbc7170bbb530e9711d2d02ba772003737a49a',
  })

  depends_on 'util_linux'
  depends_on 'm4'
  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'libxslt'
  depends_on 'libtool'
  depends_on 'gperf'

  def self.build
    system 'autoreconf -f -i -s'
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
