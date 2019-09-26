require 'package'

class Bacon < Package
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'http://www.basic-converter.org/'
  version '3.9.2b3'
  source_url 'https://basic-converter.org/stable/bacon-3.9.2b3.tar.gz'
  source_sha256 '2ecd99b478dca48fc0421b19165b35e2cd57b84253b2b494c610233151324bc6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.9.2b3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.9.2b3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.9.2b3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.9.2b3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '24e02e1ac6dadbd7f36ee689c9c1ec012e871f488cece03cc3d975d91ae0301d',
     armv7l: '24e02e1ac6dadbd7f36ee689c9c1ec012e871f488cece03cc3d975d91ae0301d',
       i686: '48721711a984c4f8cd4a6279586b2872292b29ed7be404415c7b37ea663f823d',
     x86_64: 'c11e702b654b1fc9f3503c815d75b3f87b92240952611688daf0355e935b77fc',
  })

  def self.build
    system 'sed -i "s,/usr/share,\$\(DATADIR\)," Makefile.in'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-gui-fltk',
      '--disable-gui-gtk'
    system 'make', '-j1' # parallel builds don't work with bacon
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
