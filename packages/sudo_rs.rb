# Adapted from Arch Linux sudo-rs PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=sudo-rs

require 'buildsystems/rust'

class Sudo_rs < RUST
  description 'A safety oriented and memory safe implementation of sudo and su written in Rust.'
  homepage 'https://github.com/trifectatechfoundation/sudo-rs'
  version '0.2.8'
  license 'Apache-2.0 AND MIT'
  compatibility 'all'
  source_url 'https://github.com/trifectatechfoundation/sudo-rs.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c9c94f9fc41132b951cf6126f33a3eab60c36d9d1002873d0f5524ca9e7f6860',
     armv7l: 'c9c94f9fc41132b951cf6126f33a3eab60c36d9d1002873d0f5524ca9e7f6860',
       i686: 'f3e3cae97206f4e07ecd8fe16888f48666b86a57a30f9739a8688a794bfd3ffc',
     x86_64: '4ce02efa90ef7052a06685bce6d6fbdc815e00e8f9d4a5695f64dc473d19768d'
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
