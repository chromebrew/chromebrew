require 'package'

class Mtdev < Package
  description 'The mtdev is a stand-alone library which transforms all variants of kernel MT events to the slotted type B protocol.'
  homepage 'http://bitmath.org/code/mtdev'
  version '1.1.5'
  source_url 'http://bitmath.org/code/mtdev/mtdev-1.1.5.tar.bz2'
  source_sha256 '6677d5708a7948840de734d8b4675d5980d4561171c5a8e89e54adf7a13eba7f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mtdev-1.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mtdev-1.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mtdev-1.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mtdev-1.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd96cf8121e0f076184adee6bc54f46fbb628aa0d7ae4155ae67dcffcea59eb3a',
     armv7l: 'd96cf8121e0f076184adee6bc54f46fbb628aa0d7ae4155ae67dcffcea59eb3a',
       i686: '5bd4010b81ed7c678ba19e5f7d35a4f90558158fa6ff43c378f7bba88279f742',
     x86_64: '588cf1c0f1dee0596d32709345a2cb1dd2a3102802f1b13653b275d5e351cc33',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
