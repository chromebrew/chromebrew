require 'package'

class Xf86vidmodeproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.3'
  source_url 'https://www.x.org/archive/individual/proto/xf86vidmodeproto-2.3.tar.gz'
  source_sha256 '4bdb8d868f65783f58d9619232a31a2c309e7ae15d24ce5efc579a732aaa271d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xf86vidmodeproto-2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xf86vidmodeproto-2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xf86vidmodeproto-2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xf86vidmodeproto-2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a52f52e746f0796b9cfc85bee71ce800723c6e1c871db2cb2cb7b62e314cfda7',
     armv7l: 'a52f52e746f0796b9cfc85bee71ce800723c6e1c871db2cb2cb7b62e314cfda7',
       i686: 'a82eb3843516633500b7ba44d8df2b36a6f209c64e13e93424793566fcd7ea80',
     x86_64: 'e6ce35de0c3ac275a2a65a742903db88ec72ba7dd179893513198cb15bf5a7dc',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
