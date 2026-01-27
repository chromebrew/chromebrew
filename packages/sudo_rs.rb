# Adapted from Arch Linux sudo-rs PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=sudo-rs

require 'buildsystems/rust'

class Sudo_rs < RUST
  description 'A safety oriented and memory safe implementation of sudo and su written in Rust.'
  homepage 'https://github.com/trifectatechfoundation/sudo-rs'
  version '0.2.11'
  license 'Apache-2.0 AND MIT'
  compatibility 'all'
  source_url 'https://github.com/trifectatechfoundation/sudo-rs.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e849b1f086888c6798ebe069c994bc0b8877341ac4efefb52279ce711d8a4ba9',
     armv7l: 'e849b1f086888c6798ebe069c994bc0b8877341ac4efefb52279ce711d8a4ba9',
       i686: '9721d5e3c6764654a019dd0a19127ff6fb5393753c3e17586528cb70ebe8bb34',
     x86_64: '03e980b15ba7b0edf43c49887816b32850b252cfa6763104c07cae278ad9b11c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'linux_pam' # R

  conflicts_ok # su conflict with util_linux

  rust_features 'pam-login'

  def self.postinstall
    puts 'Installation of sudo_rs will fail unless in the Chromebrew container or crew_sudo has been installed.'.orange unless CREW_IN_CONTAINER

    %w[su sudo visudo].each do |bin|
      system "/usr/bin/sudo chown root:root #{CREW_PREFIX}/bin/#{bin}", exception: false
      system "/usr/bin/sudo chmod 4755 #{CREW_PREFIX}/bin/#{bin}", exception: false
    end
  end
end
