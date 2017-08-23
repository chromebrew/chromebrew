require 'package'

class Mono < Package
  description 'Mono is a software platform designed to allow developers to easily create cross platform applications part of the .NET Foundation.'
  homepage 'http://www.mono-project.com/'
  version '5.4.0.135'
  source_url 'http://download.mono-project.com/sources/mono/mono-5.4.0.135.tar.bz2'
  source_sha256 '561af157ece41f0fc54dc3812bcbef6a04927274508104621b04fda810387ade'

  def self.build
    system "./configure","--disable-dependency-tracking","--disable-silent-rules","--enable-nls=no","--prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
