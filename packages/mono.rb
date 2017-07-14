require 'package'

class Mono < Package
  description 'Mono is a software platform designed to allow developers to easily create cross platform applications part of the .NET Foundation.'
  homepage 'http://www.mono-project.com/'
  version '4.4.0.148-1'
  source_url 'http://download.mono-project.com/sources/mono/mono-4.4.0.148.tar.bz2'
  source_sha256 '38ad527608c26b2637472602d91d6af203dc4202be915e583fdc9e3a9252a5f3'

  def self.build
    system "./configure","--disable-dependency-tracking","--disable-silent-rules","--enable-nls=no","--prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
