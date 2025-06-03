# Adapted from Arch Linux sudo-rs PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=sudo-rs

require 'buildsystems/rust'

class Sudo_rs < RUST
  description 'A safety oriented and memory safe implementation of sudo and su written in Rust.'
  homepage 'https://github.com/trifectatechfoundation/sudo-rs'
  version '0.2.6-775d01a'
  license 'Apache-2.0 AND MIT'
  compatibility 'all'
  source_url 'https://github.com/trifectatechfoundation/sudo-rs.git'
  git_hashtag '775d01ae1adc2734ea594b353335f5b566973e67'
  # git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '93c9e7ee5f8d4bee0cc65ea3c1834d534d2e7bd00c3c0c29bd9743bfd8377fd4',
     armv7l: '93c9e7ee5f8d4bee0cc65ea3c1834d534d2e7bd00c3c0c29bd9743bfd8377fd4',
       i686: 'b6abe87c48b64fee3427941c544d2d0da73666c0a44d99a7d10b3cfdca57bb96',
     x86_64: '315c8376828e51bd3f4669a68695a78128187aa686858fc797ec679cf884a14d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
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
