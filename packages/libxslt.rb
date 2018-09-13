require 'package'

class Libxslt < Package
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'http://xmlsoft.org/libxslt/'
  version '1.1.32-1'
  source_url 'http://xmlsoft.org/sources/libxslt-1.1.32.tar.gz'
  source_sha256 '526ecd0abaf4a7789041622c3950c0e7f2c4c8835471515fd77eec684a355460'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.32-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.32-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.32-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.32-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '28296ca12d9a571364eb06e53711f0e1ab746c7e70f1c31a825368a4cb0b933a',
     armv7l: '28296ca12d9a571364eb06e53711f0e1ab746c7e70f1c31a825368a4cb0b933a',
       i686: '6c8a7b6e47087792bdad09e5e4d5cb35ae283d3bb0854692271087ec7a3b884b',
     x86_64: 'f47fd5f5d4a975967b8d191b5dbfb97cf82f3293794d2b07766dc34bb5a7cf57',
  })

  depends_on 'libxml2_python'
  depends_on 'libgcrypt'
  depends_on 'docbook_xsl'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-static'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
