require 'package'

class Wxwidgets < Package
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  version '3.0.4'
  source_url 'https://github.com/wxWidgets/wxWidgets/releases/download/v3.0.4/wxWidgets-3.0.4.tar.bz2'
  source_sha256 '96157f988d261b7368e5340afa1a0cad943768f35929c22841f62c25b17bf7f0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f4ccfde2ce01be971af64b1a76cce5b8748352c30ac67d51085dba02d8d60060',
     armv7l: 'f4ccfde2ce01be971af64b1a76cce5b8748352c30ac67d51085dba02d8d60060',
       i686: '2b0024005566d7d45de96f2fe8a417859cbccd2f9061039adfcd782e0165426d',
     x86_64: 'c24c461c76af35ce55fe34b442d31ed090afe45c971902287c44d8d77f332e22',
  })

  depends_on 'gtk3'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
