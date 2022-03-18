require 'package'

class Exa < Package
  description 'Modern replacement for \'ls\''
  homepage 'https://the.exa.website'
  @_ver = '0.10.1'
  version @_ver
  license 'Apache-2.0, MIT and Unlicense'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://github.com/ogham/exa.git'
  git_hashtag 'v' + @_ver

  depends_on 'rust' => :build
  depends_on 'pandoc' => :build
  depends_on 'libgit2'

  def self.build
    system 'cargo build --release -v'
    system 'pandoc --standalone -f markdown -t man man/exa.1.md | tee exa.1 1> /dev/null'
    system 'pandoc --standalone -f markdown -t man man/exa_colors.5.md | tee exa_colors.5 1> /dev/null'
  end

  def self.check
    system 'cargo test --all -v'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/bash-completion/completions/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/zsh/site-functions/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/fish/vendor_completions.d/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man5/"
    FileUtils.install 'target/release/exa', "#{CREW_DEST_PREFIX}/bin/exa", mode: 0o755
    FileUtils.install 'completions/completions.bash', "#{CREW_DEST_PREFIX}/share/bash-completion/completions/exa", mode: 0o644
    FileUtils.install 'completions/completions.zsh', "#{CREW_DEST_PREFIX}/share/zsh/site-functions/_exa", mode: 0o644
    FileUtils.install 'completions/completions.fish', "#{CREW_DEST_PREFIX}/share/fish/vendor_completions.d/exa.fish", mode: 0o644
    FileUtils.install 'exa.1', "#{CREW_DEST_MAN_PREFIX}/man1/exa.1", mode: 0o644
    FileUtils.install 'exa_colors.5', "#{CREW_DEST_MAN_PREFIX}/man5/exa_colors.5", mode: 0o644
  end
end
