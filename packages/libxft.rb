require 'package'

class Libxft < Package
  description 'X.org X FreeType interface library'
  homepage 'http://www.x.org'
  version '2.3.3'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXft-2.3.3.tar.bz2'
  source_sha256 '225c68e616dd29dbb27809e45e9eadf18e4d74c50be43020ef20015274529216'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxft-2.3.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxft-2.3.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxft-2.3.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxft-2.3.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '609b249aaa1dcd93cac3d16996dc8c0141c0150d288ff2bf9fe004e7cc5396ab',
     armv7l: '609b249aaa1dcd93cac3d16996dc8c0141c0150d288ff2bf9fe004e7cc5396ab',
       i686: 'c8c994cc8ae2d890e4c9410b84f8987c7f993a161bb1986ba547448bcd7de732',
     x86_64: 'cfe26131953575e93d3254fbc87a314379e66ed6c33445435b77bcf9236ed7cc',
  })

  depends_on 'libxrender'
  depends_on 'libx11'
  depends_on 'fontconfig'
  depends_on 'util_macros'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
