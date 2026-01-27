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
    aarch64: '08695b92aa36d0c7acbf4fd41dcbefcf806689e84f5049405a55d09413953d87',
     armv7l: '08695b92aa36d0c7acbf4fd41dcbefcf806689e84f5049405a55d09413953d87',
       i686: 'f7210dec62ea359a9b614e8ac74b8dbe6d85ee27b5c48bd33ee81ec8dcba7abc',
     x86_64: 'ca797bc8a9670fd6e23eb2df23e2f43fad0dbb563ae7637c1ccef1b233222208'
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
