require 'package'

class Rav1e < Package
  description 'An AV1 encoder focused on speed and safety'
  homepage 'https://github.com/xiph/rav1e/'
  version '0.8.1'
  license 'BSD-2, Apache-2.0, MIT and Unlicense'
  compatibility 'all'
  source_url 'https://github.com/xiph/rav1e.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '315ec6326337d5a7f3576c97fd7ecad8197ce9f3c4177692e3f667cb1d00bcef',
     armv7l: '315ec6326337d5a7f3576c97fd7ecad8197ce9f3c4177692e3f667cb1d00bcef',
       i686: '1f4a0a3f23fef826301085f9bc615059b56041a2aa9267876978d38fb6f084a1',
     x86_64: 'c853af1d920d63f20e2a87a2e3f6e4da4762f5b936017a2e9dbc9bf47dd1236c'
  })

  depends_on 'cargo_c' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libaom' => :library
  depends_on 'libgit2' => :library
  depends_on 'nasm' => :build
  depends_on 'rust' => :build

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
