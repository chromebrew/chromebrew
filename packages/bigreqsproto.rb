require 'package'

class Bigreqsproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.1.2'
  source_url 'https://www.x.org/archive/individual/proto/bigreqsproto-1.1.2.tar.gz'
  source_sha256 'de68a1a9dd1a1219ad73531bff9f662bc62fcd777387549c43cd282399f4a6ea'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/bigreqsproto-1.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/bigreqsproto-1.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/bigreqsproto-1.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/bigreqsproto-1.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '87ebece074d85c84fb55414d83b0bfb5625c6077a11c7ed9361b602fa8cb9d37',
     armv7l: '87ebece074d85c84fb55414d83b0bfb5625c6077a11c7ed9361b602fa8cb9d37',
       i686: 'c274cfe95321c2fd343aa67a64e5879fad207c328c1847b2cafd4947edb6bd71',
     x86_64: 'f93e9f194a8c91f981c07064bf7a057b9592bf19ed67ad9202a3f2d77d8c077c',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
