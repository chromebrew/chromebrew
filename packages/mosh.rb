require 'package'

class Mosh < Package
  description 'Remote terminal application that allows roaming, supports intermittent connectivity, and provides intelligent local echo and line editing of user keystrokes.'
  homepage 'https://mosh.org/'
  version '1.3.2-3'
  compatibility 'all'
  source_url 'https://mosh.org/mosh-1.3.2.tar.gz'
  source_sha256 'da600573dfa827d88ce114e0fed30210689381bbdcff543c931e4d6a2e851216'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mosh-1.3.2-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mosh-1.3.2-3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mosh-1.3.2-3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mosh-1.3.2-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '206acadc595fd9645a1b1f31293774c8aaaae75f6ea3f0ae766c8915a0657c75',
     armv7l: '206acadc595fd9645a1b1f31293774c8aaaae75f6ea3f0ae766c8915a0657c75',
       i686: 'f42e4dd4f593f47faac209e289826199849480262abd2b99faf8152396bcaae7',
     x86_64: '9851ac9520d24cfa02881eaba610cecd4e14b7a1caffb0a2c63b18eb6c745030',
  })

  depends_on 'protobuf'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
