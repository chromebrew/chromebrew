require 'package'

class Bacon < Package
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'http://www.basic-converter.org/'
  version '3.7.1'
  source_url 'http://www.basic-converter.org/stable/bacon-3.7.1.tar.gz'
  source_sha256 'b097fbdb4ba30b82ef3280bb133c705b26158eb7608354d1074cb119ab842760'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.7.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.7.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.7.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.7.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '138c53f6065e75e893a85104677c07b48772e5c371d6dbf5c0061d50960e1a42',
     armv7l: '138c53f6065e75e893a85104677c07b48772e5c371d6dbf5c0061d50960e1a42',
       i686: 'fc3368cd1661cbd313009a2173d7f713cf0d6016a867be7a17d03624fb947c6f',
     x86_64: '955d11dd8c94216eafcfdf50ca5d686453986f3da7fd7209224256b10673316c',
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
