require 'buildsystems/rust'

class Fd < RUST
  description "A simple, fast and user-friendly alternative to 'find'."
  homepage 'https://github.com/sharkdp/fd/'
  version '10.5.2'
  license 'Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/sharkdp/fd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0cf6148453384fc320e3daa37a4a2a067eb96ce77ddf8a08ab237b989840029c',
     armv7l: '0cf6148453384fc320e3daa37a4a2a067eb96ce77ddf8a08ab237b989840029c',
       i686: '49dd784b8458e2d474ec94ee2bb572b81d4a9086c22568b183e7595d937a238d',
     x86_64: '6bfa75e4c023b7e33a8681218b5c5ee9eb00930e2112693e0afd59fabd4a4197'
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
