require 'package'

class Libnl3 < Package
  description 'Library for applications dealing with netlink sockets.'
  homepage 'http://www.infradead.org/~tgr/libnl/'
  version '3.2.25'
  source_url 'http://www.infradead.org/~tgr/libnl/files/libnl-3.2.25.tar.gz'
  source_sha1 'b7a4981f7edf7398256d35fd3c0b87bc84ae27d1'

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
