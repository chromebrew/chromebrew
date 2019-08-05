require 'package'

class Bacon < Package
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'http://www.basic-converter.org/'
  version '3.9.1'
  source_url 'http://www.basic-converter.org/stable/bacon-3.9.1.tar.gz'
  source_sha256 'ad1da72c92f8956b18cab9bd7cc505eb7f5515217f02ae47545328743195591f'

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
