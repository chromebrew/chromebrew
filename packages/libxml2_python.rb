require 'package'

class Libxml2_python < Package
  description 'Libxml2 (python module) is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.8'
  source_url 'ftp://xmlsoft.org/libxml2/libxml2-2.9.8.tar.gz'
  source_sha256 '0b74e51595654f958148759cfef0993114ddccccbb6f31aee018f3558e8e2732'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '23796c5b545d2c24568a4dc713340186990cfe3e0554832d39745f2db37cbd9f',
     armv7l: '23796c5b545d2c24568a4dc713340186990cfe3e0554832d39745f2db37cbd9f',
       i686: 'c79cbf58a05613a032c6d4f2707716298d181cebea0355c7dfe30cfc158fbd39',
     x86_64: '37e3c41d54d34e190e955c7e02dc8028c3ca761065f403d1e1a24310ace15032',
  })

  depends_on 'python27'
  depends_on 'libxml2'

  def self.build
    Dir.chdir("python") do
      system "LDFLAGS=-L#{CREW_LIB_PREFIX} python2 setup.py build"
    end
  end

  def self.install
    Dir.chdir("python") do
      system "python2 setup.py install --root=#{CREW_DEST_DIR}"
    end
  end

end
