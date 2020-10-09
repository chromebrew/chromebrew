require 'package'

class Keybase < Package
  description 'Keybase is encryption for everyone. Installs keybase cli'
  homepage 'https://keybase.io'
  version '5.5.1'
  compatibility 'all'
  source_url 'https://github.com/keybase/client/archive/v5.5.1.tar.gz'
  source_sha256 'a65dc4b62fc1299dd17da52ddd2484fa1dc1e7d2a4776c3a6e112ee020980b12'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/keybase-5.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/keybase-5.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/keybase-5.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/keybase-5.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '248fe6da5cd0a7c8e4663901a6acbcb94ca1347291309545e3e068aad6a0dd2d',
     armv7l: '248fe6da5cd0a7c8e4663901a6acbcb94ca1347291309545e3e068aad6a0dd2d',
       i686: '15662482b0381d8a3053897f21059bd425f87e06cd907c7ceb3e8f6e453f2afb',
     x86_64: '554a661f752277920cb572de6aad58d0888e188defc0a4fb79ed8a0a3d8eadb2',
  })

  depends_on 'go' => :build

  def self.install
    system "go get github.com/keybase/client/go/keybase"
    system "go build -o #{CREW_DEST_PREFIX}/bin/keybase -tags production github.com/keybase/client/go/keybase"
  end
end
