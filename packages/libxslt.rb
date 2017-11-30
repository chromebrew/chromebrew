require 'package'

class Libxslt < Package
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'http://xmlsoft.org/libxslt/'
  version '1.1.32'
  source_url 'http://xmlsoft.org/sources/libxslt-1.1.32.tar.gz'
  source_sha256 '526ecd0abaf4a7789041622c3950c0e7f2c4c8835471515fd77eec684a355460'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.32-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.32-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.32-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.32-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c9edcdbefad60a9b0b054fb8570adf6d7d27f711bd78fc7d608e9fca789cbba4',
     armv7l: 'c9edcdbefad60a9b0b054fb8570adf6d7d27f711bd78fc7d608e9fca789cbba4',
       i686: 'acd156aaa74e26070d956fb5cdb6d7ef4613b3cb38f7ae7f48c3998987a5e88d',
     x86_64: '3b34fc2e1c0178f51017d739ccb3765e3dc360f30c5a578942c9da612ed0c92a',
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
