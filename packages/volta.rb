require 'package'

class Volta < Package
  description 'JS Toolchains as Code'
  homepage 'https://volta.sh/'
  version '2.0.2'
  license 'BSD-2 Clause'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/volta-cli/volta.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2775fd02248e9a0109488d8bbea543455f3fb967e1bbdfc7579df0ee0791f266',
     armv7l: '2775fd02248e9a0109488d8bbea543455f3fb967e1bbdfc7579df0ee0791f266',
     x86_64: '237271de035625f660d0af903f5319b49e34e8c8b89cc121b7c013bb8b68dbbf'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'rust' => :build

  def self.build
    system 'cargo build --release'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'target/release/volta', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install 'target/release/volta-migrate', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install 'target/release/volta-shim', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
