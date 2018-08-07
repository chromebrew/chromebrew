require 'package'

class Xterm < Package
  description 'The xterm program is a terminal emulator for the X Window System.'
  homepage 'https://invisible-island.net/xterm/'
  version '333'
  source_url 'ftp://ftp.invisible-island.net/xterm/xterm-333.tgz'
  source_sha256 '2f1d42014e55c8036c6b29a847b31d3b5c1a3a35b126993ae6d3f05e8da0ef78'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
    system "make install-ti DESTDIR=#{CREW_DEST_DIR}"
  end
end
