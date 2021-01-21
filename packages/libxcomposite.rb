require 'package'

class Libxcomposite < Package
  description 'X.org X Composite Library'
  homepage 'http://www.x.org'
  version '0.4.4-0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXcomposite-0.4.4.tar.gz'
  source_sha256 '83c04649819c6f52cda1b0ce8bcdcc48ad8618428ad803fb07f20b802f1bdad1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcomposite-0.4.4-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxcomposite-0.4.4-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxcomposite-0.4.4-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcomposite-0.4.4-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '51fed1a509655b6ec0519cb794a76d88ad32a8101afe229f1fc61447c795524b',
     armv7l: '51fed1a509655b6ec0519cb794a76d88ad32a8101afe229f1fc61447c795524b',
       i686: 'e19d057513a36b18d11e0dc581dadb8df326ec9544faec0bc52c1345cd422e79',
     x86_64: '98e5446890fee2b29f9d214c683216a9a1611776b2e408d0143773477bf94c50',
  })


  depends_on 'libxfixes'
  depends_on 'libxext'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
