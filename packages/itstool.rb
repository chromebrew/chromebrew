require 'package'

class Itstool < Package
  description 'Translate XML with PO files using W3C Internationalization Tag Set rules'
  homepage 'http://itstool.org/'
  version '2.0.6'
  compatibility 'all'
  source_url 'https://github.com/itstool/itstool/archive/2.0.6.tar.gz'
  source_sha256 'bda0b08e9a1db885c9d7d1545535e9814dd8931d5b8dd5ab4a47bd769d0130c6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/itstool-2.0.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/itstool-2.0.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/itstool-2.0.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/itstool-2.0.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '35a0d41b76930ad6ac3111cc6f0b3b9a5defc0e0889953ecb0c20279d65322b1',
     armv7l: '35a0d41b76930ad6ac3111cc6f0b3b9a5defc0e0889953ecb0c20279d65322b1',
       i686: 'f29590049adb39b313121007c280bfa25a13db9f04a35b0760dcff86bce6a828',
     x86_64: '14f2395c59768e563a6e13bd5115108391ed498fbe637b7865306c6a59759bc7',
  })

  def self.build
    system './autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

   def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

end
