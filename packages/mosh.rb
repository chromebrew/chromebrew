require 'package'

class Mosh < Package
  description 'Remote terminal application that allows roaming, supports intermittent connectivity, and provides intelligent local echo and line editing of user keystrokes.'
  homepage 'https://mosh.org/'
  version '1.3.2-2'
  source_url 'https://mosh.org/mosh-1.3.2.tar.gz'
  source_sha256 'da600573dfa827d88ce114e0fed30210689381bbdcff543c931e4d6a2e851216'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mosh-1.3.2-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mosh-1.3.2-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mosh-1.3.2-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mosh-1.3.2-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bce0bb81f48ebe684f46f9dc3271288bd4db39563ac905e97b91ef332bf9e496',
     armv7l: 'bce0bb81f48ebe684f46f9dc3271288bd4db39563ac905e97b91ef332bf9e496',
       i686: '53611e546ecbcb1c6f1e5055d54b3119489a1d31756900d6c312e67687068af5',
     x86_64: 'fb66808fe08846e07443851e0b66ec638aa2fdd18b8308bf219b05c0f02c5bce',
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
