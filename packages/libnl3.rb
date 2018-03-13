require 'package'

class Libnl3 < Package
  description 'Library for applications dealing with netlink sockets.'
  homepage 'http://www.infradead.org/~tgr/libnl/'
  version '3.2.25-0'
  source_url 'https://www.infradead.org/~tgr/libnl/files/libnl-3.2.25.tar.gz'
  source_sha256 '8beb7590674957b931de6b7f81c530b85dc7c1ad8fbda015398bc1e8d1ce8ec5'


  def self.build
	system "./configure \
		--prefix=#{CREW_PREFIX} \
		--libdir=#{CREW_LIB_PREFIX} \
                --sysconfdir=#{CREW_PREFIX}/etc \
                --sbindir=#{CREW_PREFIX}/sbin \
                --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
