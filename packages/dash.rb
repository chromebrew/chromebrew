require 'package'

class Dash < Package
  description 'The Debian Almquist Shell (dash) is a POSIX-compliant shell derived from ash that executes scripts faster than bash and has fewer library dependencies.'
  homepage 'https://salsa.debian.org/debian/dash'
  version '0.5.11.1'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/dash/-/archive/upstream/0.5.11.1/dash-upstream-0.5.11.1.tar.bz2'
  source_sha256 '4bb75944bb47fa6d1cf1e8a3ff941f6f1fb23497b553446e9f615d52d07ef1e7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dash-0.5.11.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dash-0.5.11.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dash-0.5.11.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dash-0.5.11.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1b44e3da6bfc8c4e10752b14da464d8a04b748025de69423f944fac8035dbb96',
     armv7l: '1b44e3da6bfc8c4e10752b14da464d8a04b748025de69423f944fac8035dbb96',
       i686: 'ac582d141f234881f09860bc400688b0462d92431a5ef739c59687e09cdb9299',
     x86_64: 'fc193b1d169b2341cd99e329552740656706ae3e22867733eac7d2f7873053b8',
  })

  depends_on 'libedit'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-libedit"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
