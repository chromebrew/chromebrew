require 'buildsystems/rust'

class Fd < RUST
  description "A simple, fast and user-friendly alternative to 'find'."
  homepage 'https://github.com/sharkdp/fd/'
  version '10.5.0'
  license 'Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/sharkdp/fd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ad031ceafac9ff5679aedcdda73b8bd1849bfed0e8023dfc9e8286834beab669',
     armv7l: 'ad031ceafac9ff5679aedcdda73b8bd1849bfed0e8023dfc9e8286834beab669',
       i686: '7bda1cf1d1b7c850edec864418d510d7c4d239482f21793bd87978facf77c49a',
     x86_64: '0ea59a410fd2050c26bbdea3c0a5f901ab31031969d090d35b6864f986a829dc'
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
