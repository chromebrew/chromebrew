require 'package'

class Mono < Package
  version '4.4.0.148'
  source_url 'http://download.mono-project.com/sources/mono/mono-4.4.0.148.tar.bz2'
  source_sha1 '09eb17ee5b686136436c385e18495630381933f8'

  def self.build
    system "./configure","--disable-dependency-tracking","--disable-silent-rules","--enable-nls=no","prefix=#{CREW_DEST_DIR}/usr/local"
    system "make"
  end

  def self.install
    system "make", "PREFIX=#{CREW_DEST_DIR}/usr/local", "install"
  end
end