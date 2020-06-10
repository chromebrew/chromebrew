require 'package'

class Libxft < Package
  description 'X.org X FreeType interface library'
  homepage 'http://www.x.org'
  version '2.3.2'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXft-2.3.2.tar.gz'
  source_sha256 '26cdddcc70b187833cbe9dc54df1864ba4c03a7175b2ca9276de9f05dce74507'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxft-2.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxft-2.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxft-2.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxft-2.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0ec0c51fca352e295132a541f2972c8811b4d9c6277adce53e8e843af5356e6e',
     armv7l: '0ec0c51fca352e295132a541f2972c8811b4d9c6277adce53e8e843af5356e6e',
       i686: '7dfcb1711c0c654518f3da4921de49a09b90dfe9621baa2d20a1ca61645c5daf',
     x86_64: 'bc523b75dd9dbd750809c7865a75f896b4a12ee9089a8de8a64edd162a723ac8',
  })

  depends_on 'libxrender'
  depends_on 'libx11'
  depends_on 'fontconfig'
  depends_on 'util_macros'
  depends_on 'zlibpkg'
  depends_on 'harfbuzz'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
