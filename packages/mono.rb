require 'package'

class Mono < Package
  version '4.4.0.148-1'
  source_url 'http://download.mono-project.com/sources/mono/mono-4.4.0.148.tar.bz2'
  source_sha1 '8da7726b7c09df97856b55eda062356666928d35'

  def self.build
    system "./configure","--disable-dependency-tracking","--disable-silent-rules","--enable-nls=no","--prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
