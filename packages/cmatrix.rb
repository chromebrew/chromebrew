require 'package'

class Cmatrix < Package
  description "CMatrix is a program to see the cool scrolling lines from 'The Matrix' movie."
  homepage 'http://www.asty.org/cmatrix/'
  version '1.2'
  compatibility 'all'
  source_url 'https://github.com/abishekvashok/cmatrix/archive/1.2.tar.gz'
  source_sha256 '6b0b9aff4585147843c4cf8a8c9c6048500f66dc4887a38922197dfa326b57c8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmatrix-1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmatrix-1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmatrix-1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmatrix-1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '370bcaf095ffc55515a98a1e6e3be9c4f47c0eab4d4b71893984a520873cd35e',
     armv7l: '370bcaf095ffc55515a98a1e6e3be9c4f47c0eab4d4b71893984a520873cd35e',
       i686: '8ea2065704befa25c4db8dbf394553dc7a4eac6457242fa0e85be77d733b7f24',
     x86_64: '0aee56b9ea46a56508c44cb47e12308907aef1a9cf2c748f720c4d6cf21fe503',
  })

  depends_on 'ncurses'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses ./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
