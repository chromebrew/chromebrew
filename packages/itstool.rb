require 'package'

class Itstool < Package
  description 'Translate XML with PO files using W3C Internationalization Tag Set rules'
  homepage 'http://itstool.org/'
  version '2.0.6'
  source_url 'https://github.com/itstool/itstool/archive/2.0.6.tar.gz'
  source_sha256 'bda0b08e9a1db885c9d7d1545535e9814dd8931d5b8dd5ab4a47bd769d0130c6'

  binary_url ({
  })
  binary_sha256 ({
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
