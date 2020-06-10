require 'package'

class Npth < Package
  description 'nPth is a library to provide the GNU Pth API and thus a non-preemptive threads implementation.'
  homepage 'https://www.gnupg.org/related_software/npth/index.html'
  version '1.5-1'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/npth/npth-1.5.tar.bz2'
  source_sha256 '294a690c1f537b92ed829d867bee537e46be93fbd60b16c04630fbbfcd9db3c2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/npth-1.5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/npth-1.5-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/npth-1.5-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/npth-1.5-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2e1ee46afeb6ab2ed19e3245ba6f3f78d5bfec6594ab64c3f8e94ee1841616e5',
     armv7l: '2e1ee46afeb6ab2ed19e3245ba6f3f78d5bfec6594ab64c3f8e94ee1841616e5',
       i686: 'cf3ac9fe003627e7e0577a82e6d128105fa0c5805299bbbd392f1c3f57182088',
     x86_64: '29fcbdfa008f0e487ceebb1ca221eea79a56bd2937392c29ab01049d0d71699b',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
