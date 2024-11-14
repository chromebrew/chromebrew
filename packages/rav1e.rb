require 'package'

class Rav1e < Package
  description 'An AV1 encoder focused on speed and safety'
  homepage 'https://github.com/xiph/rav1e/'
  version '0.5.1-p20220927'
  license 'BSD-2, Apache-2.0, MIT and Unlicense'
  compatibility 'all'
  source_url 'https://github.com/xiph/rav1e.git'
  git_hashtag 'p20220927'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1a25d78f87f3f361cdfd4e1c98c0bea454a96bd73744b2a004d7a58b1ecfb6f0',
     armv7l: '1a25d78f87f3f361cdfd4e1c98c0bea454a96bd73744b2a004d7a58b1ecfb6f0',
       i686: 'fdf45f72a79a60b668eb49a80b6d63cb8ea7b3dd0eaa272390b105d20e3aa6a8',
     x86_64: '8caaa04e32e710632b8d5e465dd323745a2e5d6cd55957b76ddef735487643f2'
  })

  depends_on 'libaom'
  depends_on 'libgit2'
  depends_on 'rust' => :build
  depends_on 'cargo_c' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    @rust_flags = ''
    @rust_flags = 'RUSTFLAGS="-C target-cpu=x86-64-v3"' if ARCH == 'x86_64'
    system "cargo fetch \
      --manifest-path Cargo.toml"
    system "#{@rust_flags} cargo build \
      --release \
      --frozen \
      --manifest-path Cargo.toml"
    system "#{@rust_flags} cargo cbuild \
      --release \
      --frozen \
      --prefix=#{CREW_PREFIX} \
      --manifest-path Cargo.toml"
  end

  def self.install
    system "cargo install \
      --frozen \
      --offline \
      --no-track \
      --path . \
      --root #{CREW_DEST_PREFIX}"
    system "cargo cinstall \
      --frozen \
      --offline \
      --prefix=#{CREW_PREFIX} \
      --destdir=#{CREW_DEST_DIR} \
      --libdir=#{CREW_LIB_PREFIX}"
  end
end
