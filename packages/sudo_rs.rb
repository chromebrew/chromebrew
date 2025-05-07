# Adapted from Arch Linux sudo-rs PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=sudo-rs

require 'buildsystems/rust'

class Sudo_rs < RUST
  description 'A safety oriented and memory safe implementation of sudo and su written in Rust.'
  homepage 'https://github.com/trifectatechfoundation/sudo-rs'
  version '0.2.6'
  license 'Apache-2.0 AND MIT'
  compatibility 'all'
  source_url 'https://github.com/trifectatechfoundation/sudo-rs.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa5e2649728724c2d6e39e4b858dfec270487f85bb2ebb337308c5e436eef7b3',
     armv7l: 'aa5e2649728724c2d6e39e4b858dfec270487f85bb2ebb337308c5e436eef7b3',
       i686: '83786ea5d7aa47fdbeba0a93e5a74a5a6ec0025723889ddfe4931e84799ee764',
     x86_64: '1fd7bfcdaf161fd7e22830ef3143a9c6667340b7788311f04f03f0c172927587'
  })

  depends_on 'gcc_lib' # R
  depends_on 'linux_pam' # R

  conflicts_ok # su conflict with util_linux

  def self.postinstall
    unless CREW_IN_CONTAINER
      puts 'Installation of sudo_rs will fail unless in the Chromebrew container.'
      return
    end

    %w[su sudo visudo].each do |bin|
      system "/usr/bin/sudo chown root:root #{CREW_PREFIX}/bin/#{bin}"
      system "/usr/bin/sudo chmod 4755 #{CREW_PREFIX}/bin/#{bin}"
    end
  end
end
