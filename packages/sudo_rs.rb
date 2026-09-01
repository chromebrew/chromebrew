# Adapted from Arch Linux sudo-rs PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=sudo-rs

require 'buildsystems/rust'

class Sudo_rs < RUST
  description 'A safety oriented and memory safe implementation of sudo and su written in Rust.'
  homepage 'https://github.com/trifectatechfoundation/sudo-rs'
  version '0.2.15'
  license 'Apache-2.0 AND MIT'
  compatibility 'all'
  source_url 'https://github.com/trifectatechfoundation/sudo-rs.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f9027c4bc78955b496f7e306084471e242a6ea2d38b23dfe7f5d51b85b87706b',
     armv7l: 'f9027c4bc78955b496f7e306084471e242a6ea2d38b23dfe7f5d51b85b87706b',
       i686: '63fbfdce96d1a4ea6720b275d402ac0da62d5375b014fe4838606c0ed3023e8b',
     x86_64: 'de994a019c6541b1b084f2071db8dc24318783d55c55c2c5b06ee096db69b0a5'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'linux_pam' => :executable
  depends_on 'rust' => :build

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
