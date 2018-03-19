require 'package'

class Itstool < Package
  description 'Translate XML with PO files using W3C Internationalization Tag Set rules'
  homepage 'http://itstool.org/'
  version '2.0.4'
  source_url 'https://github.com/itstool/itstool/archive/2.0.4.tar.gz'
  source_sha256 '3221bba908eb3c19d3b6f8e195ad706afcfef9d2f552d44e45cd77f622fd6dbc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/itstool-2.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/itstool-2.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/itstool-2.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/itstool-2.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '65f59d6c2991f6bebd7716d11e30b443ada767f33f21c620eaafd2e8f56d3164',
     armv7l: '65f59d6c2991f6bebd7716d11e30b443ada767f33f21c620eaafd2e8f56d3164',
       i686: '3fd0335f8b9c45ca65994abd1facd313f061d9ed529aa54161309dd96ed5a928',
     x86_64: '1a2b5ed97e30e42bb37140eef1d0b09055c7f00e34b7b9748a3387fd38426f6a',
  })

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end
  
   def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
