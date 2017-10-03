require 'package'

class Libxslt < Package
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'http://xmlsoft.org/libxslt/'
  version '1.1.30'
  source_url 'http://xmlsoft.org/sources/libxslt-1.1.30.tar.gz'
  source_sha256 'ba65236116de8326d83378b2bd929879fa185195bc530b9d1aba72107910b6b3'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libxml2'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--without-python',
      '--disable-static'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
