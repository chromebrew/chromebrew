require 'package'

class Bc < Package
  description 'bc is an arbitrary precision numeric processing language.'
  homepage 'http://www.gnu.org/software/bc/'
  version '1.07.1'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/bc/bc-1.07.1.tar.gz'
  source_sha256 '62adfca89b0a1c0164c2cdca59ca210c1d44c3ffc46daf9931cf4942664cb02a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bc-1.07.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bc-1.07.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bc-1.07.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bc-1.07.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '23cb493a118d4ff377dc78b4e5ea2b0c35b06e1f54b3b14c0280e6f672ee2706',
     armv7l: '23cb493a118d4ff377dc78b4e5ea2b0c35b06e1f54b3b14c0280e6f672ee2706',
       i686: 'f5786594f7ff0a60cc30af18dffd2bff4a92218c2957ab30bdf9fb39afd97616',
     x86_64: 'd50ced1d0e56bb389e57bf431bbc8a18632d42dfd483b6416de9310cc782b125',
  })

  depends_on 'readline'
  depends_on 'flex'
  depends_on 'ed' => :build
  depends_on 'texinfo' => :build

  def self.build
    system "./configure", "--with-readline"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
