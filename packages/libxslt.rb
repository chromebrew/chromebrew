require 'package'

class Libxslt < Package
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'http://xmlsoft.org/libxslt/'
  version '1.1.34'
  compatibility 'all'
  source_url 'http://xmlsoft.org/sources/libxslt-1.1.34.tar.gz'
  source_sha256 '98b1bd46d6792925ad2dfe9a87452ea2adebf69dcb9919ffd55bf926a7f93f7f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.34-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.34-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.34-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.34-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'df33590a8edfc86f29fada7d5b44e5914651259015e8df726603a2ffdc23bd42',
     armv7l: 'df33590a8edfc86f29fada7d5b44e5914651259015e8df726603a2ffdc23bd42',
       i686: 'd201b063ce46e40d354c3e89472aafd54fa524bd57e70b6ab03219e4f165bd93',
     x86_64: '2ead1e30cb028f2f299056f8eea5bfb318f7346c6a65cfa4a891672560ed26bc',
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
