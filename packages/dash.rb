require 'package'

class Dash < Package
  description 'The Debian Almquist Shell (dash) is a POSIX-compliant shell derived from ash that executes scripts faster than bash and has fewer library dependencies.'
  homepage 'https://salsa.debian.org/debian/dash'
  version '0.5.11.1'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/dash/-/archive/upstream/0.5.11.1/dash-upstream-0.5.11.1.tar.bz2'
  source_sha256 '4bb75944bb47fa6d1cf1e8a3ff941f6f1fb23497b553446e9f615d52d07ef1e7'

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
