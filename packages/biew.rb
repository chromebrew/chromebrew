require 'package'

class Biew < Package
  description 'EYE (Binary EYE) is a free, portable, advanced file viewer with built-in editor for binary, hexadecimal and disassembler modes.'
  homepage 'https://sourceforge.net/projects/beye/'
  version '6.1.0-0'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/beye/biew/6.1.0/biew-610-src.tar.bz2'
  source_sha256 '2e85f03c908dd6ec832461fbfbc79169a33f4caccf48c8fe60cbd29f5fb06d17'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/biew-6.1.0-chromeos-armv7l.tar.xz',
     armv71: 'https://dl.bintray.com/chromebrew/chromebrew/biew-6.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/biew-6.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/biew-6.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f5e456e2d4f9336f151a485e37bcbf1287e33b106cb69ec2e775eaa04e20a006',
     armv7l: 'f5e456e2d4f9336f151a485e37bcbf1287e33b106cb69ec2e775eaa04e20a006',
       i686: '06540fc0a2ec15ae08b8f8cca69e8915ec3e9bdd92dbeecef974a85762d97029',
     x86_64: '140bc619e0495b7bbec4b3ca934ddb0e12cb46b793b27197dd677b73d4819ddd',
  })

  depends_on 'apriconv'
  depends_on 'ncurses'
  depends_on 'slang'

  def self.build
    system "cp -r ./biewlib/sysdep/generic ./biewlib/sysdep/arm" # add arm support
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
