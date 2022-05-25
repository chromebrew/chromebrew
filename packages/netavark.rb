# Adapted from Arch Linux netavark PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/netavark/trunk/PKGBUILD

require 'package'

class Netavark < Package
  description 'Container network stack'
  homepage 'https://github.com/containers/netavark'
  version '1.0.1'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/containers/netavark.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/netavark/1.0.1_armv7l/netavark-1.0.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/netavark/1.0.1_armv7l/netavark-1.0.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/netavark/1.0.1_i686/netavark-1.0.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/netavark/1.0.1_x86_64/netavark-1.0.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5278c97de9d0e0d550d74e59bcda1250789a02f111dd2c5ab6ac6661d1a3d8dc',
     armv7l: '5278c97de9d0e0d550d74e59bcda1250789a02f111dd2c5ab6ac6661d1a3d8dc',
       i686: 'd6b6e5ae80e4a06f894850f871ffdf57460a605a7ccfc24c8ecab69e667b14b2',
     x86_64: '78b18d0e1c2271b376b9ed5173185b39e109dd50140d5f8ba71177d4b8f46410'
  })

  depends_on 'libgit2' => :build
  depends_on 'mandown' => :build

  def self.build
    @carch = ARCH == 'aarch64' || ARCH == 'armv7l' ? 'armv7-unknown-linux-gnueabihf' : "#{ARCH}-unknown-linux-gnu"
    system "cargo fetch --locked --target #{@carch}"
    system 'CARGO_TARGET_DIR=target cargo build --frozen --release --all-features'
    system 'make -C docs'
  end

  def self.install
    FileUtils.mkdir_p %W[{CREW_DEST_LIB_PREFIX}/podman #{CREW_DEST_PREFIX}/share/doc/netavark]
    FileUtils.install 'target/release/netavark', "#{CREW_DEST_LIB_PREFIX}/podman/", mode: 0o755
    system "make DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} install -C docs"
    FileUtils.install 'README.md', "#{CREW_DEST_PREFIX}/share/doc/netavark/", mode: 0o644
  end
end
