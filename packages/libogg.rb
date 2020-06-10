require 'package'

class Libogg < Package
  description 'Ogg is a multimedia container format, and the native file and stream format for the Xiph.org multimedia codecs.'
  homepage 'https://xiph.org/ogg/'
  version '1.3.3'
  compatibility 'all'
  source_url 'https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.3.tar.xz'
  source_sha256 '4f3fc6178a533d392064f14776b23c397ed4b9f48f5de297aba73b643f955c08'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libogg-1.3.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libogg-1.3.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libogg-1.3.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libogg-1.3.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '19cedaf925df92be0217fdd752e3c78ca0e864c8b7aca395835fe80b30bd9ef8',
     armv7l: '19cedaf925df92be0217fdd752e3c78ca0e864c8b7aca395835fe80b30bd9ef8',
       i686: 'bfbbec754131107ad9e5909546c0719cfcc6c79d790944119f375e0612f7bd79',
     x86_64: '44358f6cdd5cfec18571bdbcd83208b7a94f5ca726dc60830ba6eb484b469248',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
