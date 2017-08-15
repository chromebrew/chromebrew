require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.0.7-1'
  source_url 'ftp://download.osgeo.org/libtiff/tiff-4.0.7.tar.gz'
  source_sha256 '9f43a2cfb9589e5cecaa66e16bf87f814c945f22df7ba600d63aac4632c4f019'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libtiff-4.0.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libtiff-4.0.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libtiff-4.0.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libtiff-4.0.7-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '92840df229c0852de8d4a7dbe98a3bd827866c79d4799dcc17ab54c22b16282e',
     armv7l: '92840df229c0852de8d4a7dbe98a3bd827866c79d4799dcc17ab54c22b16282e',
       i686: '64ad7e5cad77530de3bddb57381e48f32dcedc585be24b4db8b5c5dec57dd55a',
     x86_64: 'c98343ac9671681f9da5760054ab6ff8f4b15b19ba5fd88fd277d605bcb3e851',
  })

  def self.build
    system "./configure CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
