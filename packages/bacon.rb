require 'package'

class Bacon < Package
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'http://www.basic-converter.org/'
  version '3.7.1'
  source_url 'http://www.basic-converter.org/stable/bacon-3.7.1.tar.gz'
  source_sha256 'b097fbdb4ba30b82ef3280bb133c705b26158eb7608354d1074cb119ab842760'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'sed -i "s,/usr/share,\$\(DATADIR\)," Makefile.in'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-gui'
    system 'make', '-j1' # parallel builds don't work with bacon
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
