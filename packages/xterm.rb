require 'package'

class Xterm < Package
  description 'The xterm program is a terminal emulator for the X Window System.'
  homepage 'https://invisible-island.net/xterm/'
  version '333'
  source_url 'https://invisible-mirror.net/archives/xterm/xterm-333.tgz'
  source_sha256 '2f1d42014e55c8036c6b29a847b31d3b5c1a3a35b126993ae6d3f05e8da0ef78'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xterm-333-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xterm-333-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xterm-333-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xterm-333-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '90ab39740d658445bca5c4368cce5f112b7572a667211a5498fa78f01ec72671',
     armv7l: '90ab39740d658445bca5c4368cce5f112b7572a667211a5498fa78f01ec72671',
       i686: '97bfadabd2ac88155db24befc32a68f7f5213e25dd2481cf10dc0d1ce64ae67e',
     x86_64: '27454e6a81b865fb7f75ad92a472b3823cb3f1f18c4fbb40a287bc3296384d61',
  })

  depends_on 'sommelier'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
    system "make install-ti DESTDIR=#{CREW_DEST_DIR}"
  end
end
