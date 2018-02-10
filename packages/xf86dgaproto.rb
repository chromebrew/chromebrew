require 'package'

class Xf86dgaproto < Package
  description 'X.org XF86DGA protocol headers'
  homepage 'http://www.x.org'
  version '2.1'
  source_url 'https://www.x.org/archive/individual/proto/xf86dgaproto-2.1.tar.gz'
  source_sha256 '73bc6fc830cce5a0ec9c750d4702601fc0fca12d6353ede8b4c0092c9c4ca2af'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
