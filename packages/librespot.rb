require 'package'

class Librespot < Package
  description 'Open Source Spotify connect library'
  homepage 'https://github.com/librespot-org/librespot'
  version '0.1.3'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://github.com/librespot-org/librespot/archive/v0.1.3.tar.gz'
  source_sha256 '2d28a63c6dda08ecbc1245c7cfe34c9b3b29e8c5304f4aa8b65aedb899056b25'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/librespot-0.1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/librespot-0.1.3-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/librespot-0.1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ecfcbfaf8f71b1a4442535a0dc97e2d3db4dd5c67c7200deb040da74db56c099',
     armv7l: 'ecfcbfaf8f71b1a4442535a0dc97e2d3db4dd5c67c7200deb040da74db56c099',
     x86_64: '0ba9038b2e38df1d684328050885b050959ae10df0028dc390c442da647d4228',
  })

  depends_on 'rust' => :build
  depends_on 'alsa_lib'
  depends_on 'alsa_utils'

  def self.build
    system 'cargo build --release --no-default-features --features "alsa-backend"'
  end

  def self.install
    system "install -Dm755 target/release/librespot #{CREW_DEST_PREFIX}/bin/librespot"
  end
end
