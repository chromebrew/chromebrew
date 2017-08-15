require 'package'

class Lcms < Package
  description 'Little CMS intends to be an OPEN SOURCE small-footprint color management engine, with special focus on accuracy and performance.'
  homepage 'http://www.littlecms.com/'
  version '2.8'
  source_url 'https://downloads.sourceforge.net/project/lcms/lcms/2.8/lcms2-2.8.tar.gz'
  source_sha256 '66d02b229d2ea9474e62c2b6cd6720fde946155cd1d0d2bffdab829790a0fb22'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/lcms-2.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/lcms-2.8-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/lcms-2.8-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/lcms-2.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ef1a4f2b84a946f4b940cf145d0db308258e03937a959008ecd94951f073bda6',
     armv7l: 'ef1a4f2b84a946f4b940cf145d0db308258e03937a959008ecd94951f073bda6',
       i686: '597a0adaad471ea2f66a516ec9d76464d3c2ffd310e22f7fb5641e6096077994',
     x86_64: '2d8a3940bee7c5e7da15d465820ba7f59d893b3beccb30ef228d4a1bec11e344',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
