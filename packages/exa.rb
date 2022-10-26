require 'package'

class Exa < Package
  description 'Exa is a modern replacement for ls'
  homepage 'https://the.exa.website/'
  @_ver = '0.10.1'
  version "#{@_ver}-1"
  license 'Apache-2.0, MIT and Unlicense'
  compatibility 'all'
  source_url 'https://github.com/ogham/exa.git'
  git_hashtag "v#{@_ver}"

  depends_on 'libgit2'
  depends_on 'moreutils' => :build # for the sponge command
  depends_on 'rust' => :build
  depends_on 'pandoc' => :build

  def self.patch
    # Cargo.lock is outdated
    system "sed -i 's:version = \"0.11.0-pre\":version = \"0.10.1\":' Cargo.lock"
  end

  def self.prebuild
    system 'cargo fetch --locked'
  end

  def self.build
    system 'cargo build --frozen --release -v'
    %w[exa.1 exa_colors.5].each do |manpage|
      system "pandoc --standalone -f markdown -t man man/#{manpage}.md | sponge #{manpage}"
    end
  end

  def self.check
    system 'cargo test --frozen --all -v'
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
