require 'package'

class Libogg < Package
  description 'Ogg is a multimedia container format, and the native file and stream format for the Xiph.org multimedia codecs.'
  homepage 'https://xiph.org/ogg/'
  version '1.3.3'
  source_url 'https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.3.tar.xz'
  source_sha256 '4f3fc6178a533d392064f14776b23c397ed4b9f48f5de297aba73b643f955c08'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
