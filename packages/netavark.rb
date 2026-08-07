# Adapted from Arch Linux netavark PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/netavark/trunk/PKGBUILD

require 'package'

class Netavark < Package
  description 'Container network stack'
  homepage 'https://github.com/containers/netavark'
  version '2.1.0'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/containers/netavark.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bee7249109091b7dcc49a0765ca5551811c018b9f5fd7e10dd8c1f359ae17c7a',
     armv7l: 'bee7249109091b7dcc49a0765ca5551811c018b9f5fd7e10dd8c1f359ae17c7a',
       i686: 'b8dd657ed86d7c78eb1e32ed7571c7492e5591ab19e01ea10b2c1692d70f0a12',
     x86_64: '33ab84a13892f09e321d01f51db586a6880c999556a8b40e7ddd9714a78129e9'
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
