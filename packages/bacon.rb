require 'package'

class Bacon < Package
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'http://www.basic-converter.org/'
  version '3.9.1'
  source_url 'http://www.basic-converter.org/stable/bacon-3.9.1.tar.gz'
  source_sha256 'ad1da72c92f8956b18cab9bd7cc505eb7f5515217f02ae47545328743195591f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cca03b628bbec3fdf951b933a7b20a037ab23b716ff70e6c2aa895f4fdb0e140',
     armv7l: 'cca03b628bbec3fdf951b933a7b20a037ab23b716ff70e6c2aa895f4fdb0e140',
       i686: 'de727e4f192b1b493fdc7cf5cee8d44d3c1270233647069f0d1e5f12e3bef9c0',
     x86_64: '884601d8d402237c5827af5aebde04ad1b44ab82b6acd6d1b05f763495858689',
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
