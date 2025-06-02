# Adapted from Arch Linux sudo-rs PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=sudo-rs

require 'buildsystems/rust'

class Sudo_rs < RUST
  description 'A safety oriented and memory safe implementation of sudo and su written in Rust.'
  homepage 'https://github.com/trifectatechfoundation/sudo-rs'
  version '0.2.6-7a09f25'
  license 'Apache-2.0 AND MIT'
  compatibility 'all'
  source_url 'https://github.com/trifectatechfoundation/sudo-rs.git'
  git_hashtag '7a09f258c6fdd9506aaa78b20c9c034f273a2ee5'
  # git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'be92e7078c71999270149bba6939d0af8282b161e18935ca34c6b0d11196b038',
     armv7l: 'be92e7078c71999270149bba6939d0af8282b161e18935ca34c6b0d11196b038',
       i686: 'b5b02cf14d3b0bd7239ad815c642f226bb511b6962e9ebaf1926d08a1bcba31e',
     x86_64: 'd14affd43f100810b713e5e65de4f2ab0a1fafa25663ca173a8b008c9b834bcd'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'linux_pam' # R

  conflicts_ok # su conflict with util_linux

  def self.patch
    system "sed -i 's/all(target_os = \\\"linux\\\", target_env = \\\"musl\\\")/target_os = \\\"linux\\\"/g' src/system/mod.rs"
  end

  def self.postinstall
    puts 'Installation of sudo_rs will fail unless in the Chromebrew container or crew_sudo has been installed.'.orange unless CREW_IN_CONTAINER

    %w[su sudo visudo].each do |bin|
      system "/usr/bin/sudo chown root:root #{CREW_PREFIX}/bin/#{bin}", exception: false
      system "/usr/bin/sudo chmod 4755 #{CREW_PREFIX}/bin/#{bin}", exception: false
    end
  end
end
