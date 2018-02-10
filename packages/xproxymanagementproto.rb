require 'package'

class Xproxymanagementproto < Package
  description 'X.org X Proxy Management extension headers'
  homepage 'http://www.x.org'
  version '1.0.3'
  source_url 'https://www.x.org/archive/individual/proto/xproxymanagementprotocol-1.0.3.tar.gz'
  source_sha256 'c1501045ec781f36b6f867611ab2b4e81be542f5c669b2fd0cc4ec1340c42bcf'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
