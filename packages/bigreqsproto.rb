require 'package'

class Bigreqsproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.1.2-0'
  source_url 'https://www.x.org/archive/individual/proto/bigreqsproto-1.1.2.tar.gz'
  source_sha256 'de68a1a9dd1a1219ad73531bff9f662bc62fcd777387549c43cd282399f4a6ea'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bigreqsproto-1.1.2-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bigreqsproto-1.1.2-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bigreqsproto-1.1.2-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bigreqsproto-1.1.2-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: '3eaecae64b9a60e8e03987823860b2cb6f41d29eb16cf16f22d668d6a5c10efe',
     armv7l: '3eaecae64b9a60e8e03987823860b2cb6f41d29eb16cf16f22d668d6a5c10efe',
       i686: 'd1762ade0827e3a97c35c862ffa0aac612b30442e4d58a8ddf94d05aea6eb618',
     x86_64: '326c1158fdb30cc209f9c4ec5ec10bff0e68826f1cb2317fee5b7cd2ba0a1f82',

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
