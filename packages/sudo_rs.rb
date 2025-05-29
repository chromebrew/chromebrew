# Adapted from Arch Linux sudo-rs PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=sudo-rs

require 'buildsystems/rust'

class Sudo_rs < RUST
  description 'A safety oriented and memory safe implementation of sudo and su written in Rust.'
  homepage 'https://github.com/trifectatechfoundation/sudo-rs'
  version '0.2.6-2'
  license 'Apache-2.0 AND MIT'
  compatibility 'all'
  source_url 'https://github.com/trifectatechfoundation/sudo-rs.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaa',
     armv7l: 'aaaaa',
       i686: 'bbbbb',
     x86_64: 'ccccc'
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
