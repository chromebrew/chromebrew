require 'package'

class Libsm < Package
  description 'X.org X Session Management Library'
  homepage 'http://www.x.org'
  version '1.2.2'
  source_url 'https://www.x.org/archive/individual/lib/libSM-1.2.2.tar.gz'
  source_sha256 '14bb7c669ce2b8ff712fbdbf48120e3742a77edcd5e025d6b3325ed30cf120f4'

  depends_on 'libice'
  depends_on 'libx11'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end