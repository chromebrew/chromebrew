require 'package'

class Sccache < Package
  description 'Shared Compilation Cache'
  homepage 'https://github.com/mozilla/sccache/'
  @_ver = '0.2.15'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/mozilla/sccache/archive/v#{@_ver}.tar.gz"
  source_sha256 '7dbe71012f9b0b57d8475de6b36a9a3b4802e44a135e886f32c5ad1b0eb506e0'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sccache-0.2.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sccache-0.2.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sccache-0.2.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sccache-0.2.15-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0c5c81c8fb17e91e420cd2ab261800d5640519956a40c3feb74469bee303ec4e',
     armv7l: '0c5c81c8fb17e91e420cd2ab261800d5640519956a40c3feb74469bee303ec4e',
       i686: '817d47a4b92fc15e60c3f1f920965b8d6adbb0913f635abcd31135bc3ff0cde3',
     x86_64: 'abbede3efe1a1cdee32be218ec2b86781da6074a262d7c07ac23b247610b8262'
  })

  depends_on 'rust' => ':build'

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
