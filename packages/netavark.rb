# Adapted from Arch Linux netavark PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/netavark/trunk/PKGBUILD

require 'package'

class Netavark < Package
  description 'Container network stack'
  homepage 'https://github.com/containers/netavark'
  version '2.0.0'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/containers/netavark.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cc26770ad7c96e2088431bd47fd92bc9bd4fb22ad798bcb2b8e678342964e896',
     armv7l: 'cc26770ad7c96e2088431bd47fd92bc9bd4fb22ad798bcb2b8e678342964e896',
       i686: '0d8a370aab601a150d959b2b75af7a4bfd488f37d21c727b9481139f3f57d9ae',
     x86_64: '32c92aba46076831874528d7ab4be3f5337c0a1a1ec028c5a26596b6b7fd3232'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :executable
  depends_on 'glibc_lib' => :library
  depends_on 'go_md2man' => :build
  depends_on 'libgit2' => :build
  depends_on 'mandown' => :build
  depends_on 'protobuf' => :build

  def self.build
    @carch = ARCH == 'aarch64' || ARCH == 'armv7l' ? 'armv7-unknown-linux-gnueabihf' : "#{ARCH}-unknown-linux-gnu"
    system "cargo fetch --locked --target #{@carch}"
    system 'CARGO_TARGET_DIR=target cargo build --frozen --release --all-features'
    system 'make -C docs'
  end

  def self.install
    FileUtils.install 'target/release/netavark', "#{CREW_DEST_PREFIX}/bin/netavark", mode: 0o755
    system "make DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} install -C docs"
    FileUtils.install 'README.md', "#{CREW_DEST_PREFIX}/share/doc/netavark/README.md", mode: 0o644
  end
end
