require 'package'

class Fd < Package
  description "A simple, fast and user-friendly alternative to 'find'."
  homepage 'https://github.com/sharkdp/fd/'
  @_ver = '8.3.0'
  version @_ver + '-1'
  license 'Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/sharkdp/fd.git'
  git_hashtag 'v' + @_ver

  depends_on 'rust' => :build

  def self.build
    system 'cargo build --release'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/bash-completion/completions/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/zsh/site-functions/"
    FileUtils.install "target/release/fd", "#{CREW_DEST_PREFIX}/bin/fd", mode: 0o755
    FileUtils.install "target/release/build/fd-find-88bf4d216dc4818c/out/fd.bash", "#{CREW_DEST_PREFIX}/share/bash-completion/completions/fd"
    FileUtils.install "doc/fd.1", "#{CREW_DEST_MAN_PREFIX}/man1/fd.1"
    FileUtils.install "contrib/completion/_fd", "#{CREW_DEST_PREFIX}/share/zsh/site-functions/_fd"
  end

  def self.check
    system 'cargo test --release'
  end
end
