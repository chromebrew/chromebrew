require 'package'

class Libxslt < Package
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'http://xmlsoft.org/libxslt/'
  version '1.1.32'
  source_url 'http://xmlsoft.org/sources/libxslt-1.1.32.tar.gz'
  source_sha256 '526ecd0abaf4a7789041622c3950c0e7f2c4c8835471515fd77eec684a355460'

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
