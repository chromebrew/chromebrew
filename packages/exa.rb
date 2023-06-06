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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exa/0.10.1-1_armv7l/exa-0.10.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exa/0.10.1-1_armv7l/exa-0.10.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exa/0.10.1-1_i686/exa-0.10.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exa/0.10.1-1_x86_64/exa-0.10.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '322a9e66be6310b50ec98fd9810a65ff5ab55f04a9a885e03c81095dbd2ac87d',
     armv7l: '322a9e66be6310b50ec98fd9810a65ff5ab55f04a9a885e03c81095dbd2ac87d',
       i686: 'b3970d579330b011380867cfdcf55e2ec8fab7bab63d1b6b86a024b2f2fae0d4',
     x86_64: '6664ea74960837d09a049303ed36b3b766e40a85c652da2ec293279d87f9460f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libgit2' # R
  depends_on 'moreutils' => :build # for the sponge command
  depends_on 'pandoc' => :build
  depends_on 'rust' => :build

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
    FileUtils.install 'completions/completions.bash', "#{CREW_DEST_PREFIX}/share/bash-completion/completions/exa",
                      mode: 0o644
    FileUtils.install 'completions/completions.zsh', "#{CREW_DEST_PREFIX}/share/zsh/site-functions/_exa", mode: 0o644
    FileUtils.install 'completions/completions.fish', "#{CREW_DEST_PREFIX}/share/fish/vendor_completions.d/exa.fish",
                      mode: 0o644
    FileUtils.install 'exa.1', "#{CREW_DEST_MAN_PREFIX}/man1/exa.1", mode: 0o644
    FileUtils.install 'exa_colors.5', "#{CREW_DEST_MAN_PREFIX}/man5/exa_colors.5", mode: 0o644
  end
end
