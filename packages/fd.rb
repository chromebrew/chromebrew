require 'buildsystems/rust'

class Fd < RUST
  description "A simple, fast and user-friendly alternative to 'find'."
  homepage 'https://github.com/sharkdp/fd/'
  version '10.4.2'
  license 'Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/sharkdp/fd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f73056ff720be22f16bd56e7a0aa9a98f05f199f5555ad1316d2dbd87713433c',
     armv7l: 'f73056ff720be22f16bd56e7a0aa9a98f05f199f5555ad1316d2dbd87713433c',
       i686: '904f6f2e266e7a82d10e84e2d09fc17ebbe60e61d25f82414fb428ac771f1127',
     x86_64: '66bca1a50dd1abc3f7c55607cc3a438b2c7e4a6904e3c0a1c6a2e2e457ef012f'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'rust' => :build

  def self.install
    FileUtils.install 'target/release/fd', "#{CREW_DEST_PREFIX}/bin/fd", mode: 0o755
    FileUtils.install 'doc/fd.1', "#{CREW_DEST_MAN_PREFIX}/man1/fd.1", mode: 0o644
    # FileUtils.install 'fd.bash', "#{CREW_DEST_PREFIX}/etc/env.d/10-fd", mode: 0o644
    FileUtils.install 'contrib/completion/_fd', "#{CREW_DEST_HOME}/.zfunc/_fd", mode: 0o644
  end

  def self.check
    system 'cargo test --release'
  end
end
