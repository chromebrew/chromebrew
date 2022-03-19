require 'package'

class Exa < Package
  description "Exa is a modern replacement for ls"
  homepage 'https://the.exa.website/'
  @_ver = '0.10.1'
  version @_ver
  license 'Apache-2.0, MIT and Unlicense'
  compatibility 'all'
  source_url 'https://github.com/ogham/exa.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exa/0.10.1_armv7l/exa-0.10.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exa/0.10.1_armv7l/exa-0.10.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exa/0.10.1_i686/exa-0.10.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exa/0.10.1_x86_64/exa-0.10.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e565a30749d5137ea0d74b55022518d062fdbe61b0ec628acd934a9302139060',
     armv7l: 'e565a30749d5137ea0d74b55022518d062fdbe61b0ec628acd934a9302139060',
       i686: '588f32e51731a5dd6b6b0009a35ac23b11c2ab54ef52dbb653892fd719d18521',
     x86_64: '30085328379c821d79a317d75a8425c25938961335c15be9e3b3a16652f9a873'
  })

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
