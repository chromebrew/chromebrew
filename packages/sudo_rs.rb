# Adapted from Arch Linux sudo-rs PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=sudo-rs

require 'buildsystems/rust'

class Sudo_rs < RUST
  description 'A safety oriented and memory safe implementation of sudo and su written in Rust.'
  homepage 'https://github.com/trifectatechfoundation/sudo-rs'
  version '0.2.6-1'
  license 'Apache-2.0 AND MIT'
  compatibility 'all'
  source_url 'https://github.com/trifectatechfoundation/sudo-rs.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c5c1abf2f86fc0db8d677b5b1c945e894ce6fddb8b31fee0e785820cc95fc891',
     armv7l: 'c5c1abf2f86fc0db8d677b5b1c945e894ce6fddb8b31fee0e785820cc95fc891',
       i686: 'a99cb6e34734f4d07b2c6e03d16992187bc9df667e2b9d22dbf5e4e6a523c1b8',
     x86_64: '69d3b5706a2fb442fc34b9450091919ef93e7ff17beea9286c1f3e5191234af9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'linux_pam' # R

  conflicts_ok # su conflict with util_linux

  def self.postinstall
    puts 'Installation of sudo_rs will fail unless in the Chromebrew container or crew_sudo has been installed.'.orange unless CREW_IN_CONTAINER

    %w[su sudo visudo].each do |bin|
      system "/usr/bin/sudo chown root:root #{CREW_PREFIX}/bin/#{bin}", exception: false
      system "/usr/bin/sudo chmod 4755 #{CREW_PREFIX}/bin/#{bin}", exception: false
    end
  end
end
