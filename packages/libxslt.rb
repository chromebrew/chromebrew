require 'package'

class Libxslt < Package
  description 'Libxslt is the XSLT C library developed for the GNOME project. http://xmlsoft.org/libxslt/'
  homepage 'ftp://xmlsoft.org/libxml2/'
  version '1.1.33'
  source_url 'ftp://xmlsoft.org/libxml2/libxslt-1.1.33-rc1.tar.gz'
  source_sha256 'fe5c2cc487b010dac66529d494f220683dcc26b9c75e33518db9b37f52ee7f77'

  depends_on 'python27'
  depends_on 'libxml2'
  depends_on 'libgcrypt'

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
