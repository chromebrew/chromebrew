require 'package'

class Libmms < Package
  description 'MMS stream protocol library'
  homepage 'https://sourceforge.net/projects/libmms/'
  version '0.6.4'
  compatibility 'all'
  source_url 'https://download.sourceforge.net/libmms/libmms-0.6.4.tar.gz'
  source_sha256 '3c05e05aebcbfcc044d9e8c2d4646cd8359be39a3f0ba8ce4e72a9094bee704f'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libmms-0.6.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libmms-0.6.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmms-0.6.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmms-0.6.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '70ff7a70293b11b92859e7ec8b7ff6c96f8e3e34ee325f83becd2cf2efcfe99b',
     armv7l: '70ff7a70293b11b92859e7ec8b7ff6c96f8e3e34ee325f83becd2cf2efcfe99b',
       i686: '94049b0862336fb69c658698b92ff67c8f9f7521474045e49b32b9d88b99832c',
     x86_64: '33686fb9f469a60594bc2391fb8df31575f5a0a2c37e0445db875373396b9caf'
  })

  def self.patch
    system 'filefix'
  end

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
