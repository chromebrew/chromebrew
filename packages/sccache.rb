require 'package'

class Sccache < Package
  description 'Shared Compilation Cache'
  homepage 'https://github.com/mozilla/sccache/'
  version '0.2.15'
  license 'Apache-2.0, Apache-2.0-with-LLVM-exceptions, BSD, BSD-2, Boost-1.0, ISC, MIT, Unlicense and ZLIB'
  compatibility 'all'
  source_url "https://github.com/mozilla/sccache/archive/v#{version}.tar.gz"
  source_sha256 '7dbe71012f9b0b57d8475de6b36a9a3b4802e44a135e886f32c5ad1b0eb506e0'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '0c5c81c8fb17e91e420cd2ab261800d5640519956a40c3feb74469bee303ec4e',
     armv7l: '0c5c81c8fb17e91e420cd2ab261800d5640519956a40c3feb74469bee303ec4e',
       i686: '817d47a4b92fc15e60c3f1f920965b8d6adbb0913f635abcd31135bc3ff0cde3',
     x86_64: 'abbede3efe1a1cdee32be218ec2b86781da6074a262d7c07ac23b247610b8262'
  })

  depends_on 'rust' => :build

  def self.build
    system "cargo fetch \
      --manifest-path Cargo.toml"
    system "cargo build \
      --release \
      --frozen \
      --manifest-path Cargo.toml"
  end

  def self.install
    system "cargo install \
      --frozen \
      --offline \
      --no-track \
      --path . \
      --root #{CREW_DEST_PREFIX}"
  end
end
