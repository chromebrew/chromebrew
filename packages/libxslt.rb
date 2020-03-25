require 'package'

class Libxslt < Package
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'http://xmlsoft.org/libxslt/'
  version '1.1.34'
  source_url 'http://xmlsoft.org/sources/libxslt-1.1.34.tar.gz'
  source_sha256 '98b1bd46d6792925ad2dfe9a87452ea2adebf69dcb9919ffd55bf926a7f93f7f'

  binary_url ({
  })
  binary_sha256 ({
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
