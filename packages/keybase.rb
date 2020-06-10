require 'package'

class Keybase < Package
  description 'Keybase is encryption for everyone. Installs keybase cli'
  homepage 'https://keybase.io'
  version '1.0.40'
  compatibility 'all'
  source_url 'https://github.com/keybase/client/archive/v1.0.40.tar.gz'
  source_sha256 '79f11737b3bdc279b34d2b978584b3c12e1c24ccdeb3b86dbf7670aa9c634913'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/keybase-1.0.40-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/keybase-1.0.40-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/keybase-1.0.40-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/keybase-1.0.40-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '78ba216917dc6214c97f98be33c70e693a0e2d813a165d63ae4c1e7361c27f96',
     armv7l: '78ba216917dc6214c97f98be33c70e693a0e2d813a165d63ae4c1e7361c27f96',
       i686: '4a1df60226633d06cd4910688c8064b25b08c7599ddfe6d1708e3d35978d0e32',
     x86_64: 'bd75cf418a25cd90869ae292879f60121cfc68e3ad8d6e5fa9296741c9668865',
  })

  depends_on 'go'

  def self.install
    system "go get github.com/keybase/client/go/keybase"
    system "go build -o #{CREW_DEST_PREFIX}/bin/keybase -tags production github.com/keybase/client/go/keybase"
  end
end
