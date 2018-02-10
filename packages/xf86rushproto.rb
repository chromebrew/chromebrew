require 'package'

class Xf86rushproto < Package
  description 'X.org XF86Rush protocol headers'
  homepage 'http://www.x.org'
  version '1.1.2'
  source_url 'https://www.x.org/archive/individual/proto/xf86rushproto-1.1.2.tar.gz'
  source_sha256 '7d420ae7e5f0dd94c6010c764c66acc93eed7df7f81bcf93d2a57739970ec841'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
