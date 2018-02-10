require 'package'

class Libice < Package
  description 'X.org X Inter Client Exchange Library'
  homepage 'http://www.x.org'
  version '1.0.9'
  source_url 'https://www.x.org/archive/individual/lib/libICE-1.0.9.tar.gz'
  source_sha256 '7812a824a66dd654c830d21982749b3b563d9c2dfe0b88b203cefc14a891edc0'

  depends_on 'xproto'
  depends_on 'libxtrans'
  depends_on 'util_macros'  
  depends_on 'libx11'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end