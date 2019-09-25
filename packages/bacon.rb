require 'package'

class Bacon < Package
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'http://www.basic-converter.org/'
  version '3.9.2b3'
  source_url 'https://basic-converter.org/stable/bacon-3.9.2b3.tar.gz'
  source_sha256 '2ecd99b478dca48fc0421b19165b35e2cd57b84253b2b494c610233151324bc6'

  binary_url ({
  })
  binary_sha256 ({
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
