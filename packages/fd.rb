require 'buildsystems/rust'

class Fd < RUST
  description "A simple, fast and user-friendly alternative to 'find'."
  homepage 'https://github.com/sharkdp/fd/'
  version '10.5.1'
  license 'Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/sharkdp/fd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5899fca029da8a5d07eba9a677d5f5b066629eef6e5339ddd7de5c0f941f29c1',
     armv7l: '5899fca029da8a5d07eba9a677d5f5b066629eef6e5339ddd7de5c0f941f29c1',
       i686: 'f594423be542a3e4768848cc14e143872b80374dec8a5a2b20bb22822a1c8ea3',
     x86_64: 'c36c35f97541d43797ec968be7dc69ee9f3aa9effe6a6e4d86e90922932951fd'
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
