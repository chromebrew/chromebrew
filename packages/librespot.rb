require 'package'

class Librespot < Package
  description 'Open Source Spotify connect library'
  homepage 'https://github.com/librespot-org/librespot'
  version '0.1.3'
  compatibility 'all'
  source_url 'https://github.com/librespot-org/librespot/archive/v0.1.3.tar.gz'
  source_sha256 '2d28a63c6dda08ecbc1245c7cfe34c9b3b29e8c5304f4aa8b65aedb899056b25'  
  
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
