require 'package'

class Gmp < Package
  description 'GMP is a free library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating-point numbers.'
  homepage 'https://gmplib.org/'
  version '6.1.2-3'
  source_url 'https://gmplib.org/download/gmp/gmp-6.1.2.tar.lz'
  source_sha256 '12fed0532d440d2dc902e64f016aa89a33af6044b90bd1f7bca7396635105dbb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gmp-6.1.2-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gmp-6.1.2-3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gmp-6.1.2-3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gmp-6.1.2-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f0f4d5cf889790f1e7ed8f0658ce3ec59e5e2a1d090e1093cacf11d49dc77149',
     armv7l: 'f0f4d5cf889790f1e7ed8f0658ce3ec59e5e2a1d090e1093cacf11d49dc77149',
       i686: 'e87a90631b9cb7de0efddf44013dffb5953d47739795494dda741afbd6099af2',
     x86_64: 'cc5af938f7de17899ee55850dc74f1ede4f67e91473597c82687cdad68a01247',
  })

  def self.build
    system "sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' configure"
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system 'make', 'check'
  end
end
