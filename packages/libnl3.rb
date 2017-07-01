require 'package'

class Libnl3 < Package
  description 'Library for applications dealing with netlink sockets.'
  homepage 'http://www.infradead.org/~tgr/libnl/'
  version '3.2.25'
  source_url 'http://www.infradead.org/~tgr/libnl/files/libnl-3.2.25.tar.gz'
  source_sha256 '8beb7590674957b931de6b7f81c530b85dc7c1ad8fbda015398bc1e8d1ce8ec5'

  depends_on "buildessential" => :build
  depends_on "glibc"

  def self.build
    system "./configure",
      "--prefix=/usr/local",
      "--sysconfdir=/usr/local/etc",
      "--sbindir=/usr/local/sbin",
      "--disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
