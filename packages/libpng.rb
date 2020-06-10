require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version '1.6.37'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/libpng/libpng16/1.6.37/libpng-1.6.37.tar.xz'
  source_sha256 '505e70834d35383537b6491e7ae8641f1a4bed1876dbfe361201fc80868d88ca'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.37-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.37-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.37-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.37-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '14240b27d54756682cfa2c75126cb1de443faead0232e6636f4b1e36322bb85e',
     armv7l: '14240b27d54756682cfa2c75126cb1de443faead0232e6636f4b1e36322bb85e',
       i686: '85d03e11ba20b635f24c6786b1f5050ee35c515d2e7b9a43464f8896945c3c13',
     x86_64: 'bc1b016c4c947fa3fb70cc456be81b3859430579722e2189781f1403a4a96b83',
  })

  depends_on 'zlibpkg'

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking',
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
