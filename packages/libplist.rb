require 'package'

class Libplist < Package
  description 'A library to handle Apple Property List format'
  homepage 'http://www.libimobiledevice.org/'
  version '2.0.0'
  source_url 'http://www.libimobiledevice.org/downloads/libplist-2.0.0.tar.bz2'
  source_sha256 '3a7e9694c2d9a85174ba1fa92417cfabaea7f6d19631e544948dc7e17e82f602'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libplist-2.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libplist-2.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libplist-2.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libplist-2.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '361fcbe8e9ddd1ea0827c1fad4788b3f5dbf7c344eb0b44ad9c11e20fb0af72c',
     armv7l: '361fcbe8e9ddd1ea0827c1fad4788b3f5dbf7c344eb0b44ad9c11e20fb0af72c',
       i686: '1f2db0a7e401c870a8bd8a2c5b59669524e35fffbdd5f58ac8c7fa297004cb9c',
     x86_64: '67d760c5c49508d8d89b6b81cd3480183b0fee278c59d5c20d6ccf6d483afeea',
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
