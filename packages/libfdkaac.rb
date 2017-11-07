require 'package'

class Libfdkaac < Package
  description 'A standalone library of the Fraunhofer FDK AAC code from Android.'
  homepage 'https://github.com/mstorsjo/fdk-aac/'
  version '0.1.5'
  source_url 'https://github.com/mstorsjo/fdk-aac/archive/v0.1.5.tar.gz'
  source_sha256 'ff53d1d01cacc29c071e23192dfefa93bdbeaf775fc5d296259b4859d0306b79'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfdkaac-0.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfdkaac-0.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfdkaac-0.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfdkaac-0.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6e78c72d05f9f6c5cda9a001f2169693f37480dd2a1b491c824cb71668e2192f',
     armv7l: '6e78c72d05f9f6c5cda9a001f2169693f37480dd2a1b491c824cb71668e2192f',
       i686: '39350d2d8ccd2dfb1539f17ebfdab616ed0c5693c0979d0b62e3132bb6caa028',
     x86_64: 'e780727ea90e2025292c230d48bf8d722b9159a993579d9b1b54eb52b06064b9',
  })

  depends_on 'automake'

  def self.build
    system "./autogen.sh"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
