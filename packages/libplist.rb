require 'package'

class Libplist < Package
  description 'A library to handle Apple Property List format'
  homepage 'http://www.libimobiledevice.org/'
  version '2.0.0'
  source_url 'http://www.libimobiledevice.org/downloads/libplist-2.0.0.tar.bz2'
  source_sha256 '3a7e9694c2d9a85174ba1fa92417cfabaea7f6d19631e544948dc7e17e82f602'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'glib'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
