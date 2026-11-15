require 'package'

class Drill < Package
  description 'Drill is an HTTP load testing application written in Rust'
  homepage 'https://github.com/fcsonline/drill'
  version '0.9.1'
  license 'GPL-3.0'
  compatibility 'all'
  source_url 'https://github.com/fcsonline/drill.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5429409f4dd049f22ed19733c96b5d8502a1f5ca2abf5582e5a52d286d9ea68b',
     armv7l: '5429409f4dd049f22ed19733c96b5d8502a1f5ca2abf5582e5a52d286d9ea68b',
       i686: '7e20ccefd49488b41d379b61cd5dc7fa85dffb58ee0d9877c6088b8a9911a188',
     x86_64: 'ffbbb9c11f934bda6c03ca23ef62432f650909beb0dec3b719edc1a6ed784f80'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'rust' => :build

  def self.install
    system 'cargo build --release'
    FileUtils.install 'target/release/drill', "#{CREW_DEST_PREFIX}/bin/drill", mode: 0o755
  end
end
