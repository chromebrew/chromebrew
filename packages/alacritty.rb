# Adapted from Arch Linux alacritty PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/alacritty/trunk/PKGBUILD

require 'package'

class Alacritty < Package
  description 'A cross-platform, GPU-accelerated terminal emulator'
  homepage 'https://github.com/alacritty/alacritty'
  version '0.17.0'
  license 'Apache'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/alacritty/alacritty.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8942e6bc7e1cb072e749acabcd0ff1adec8c6d8a5e8926291206fe664a8217a0',
     armv7l: '8942e6bc7e1cb072e749acabcd0ff1adec8c6d8a5e8926291206fe664a8217a0',
     x86_64: '3dc9bd8900bbd4f8d52c85573233c66ebc86f149726a866a8a9702bf5be5b732'
  })

  depends_on 'fontconfig' => :executable
  depends_on 'freetype' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'libxcb' => :library
  depends_on 'libxcursor' => :library
  depends_on 'libxi' => :library
  depends_on 'libxkbcommon' => :library
  depends_on 'mesa' => :executable
  depends_on 'ncurses' => :library
  depends_on 'rust' => :build

  def self.build
    system 'CARGO_INCREMENTAL=0 cargo build --release'
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin
                         #{CREW_DEST_PREFIX}/share/bash-completion/completions
                         #{CREW_DEST_PREFIX}/share/zsh/site-functions
                         #{CREW_DEST_PREFIX}/share/fish/vendor_completions.d
                         #{CREW_DEST_PREFIX}/share/pixmaps]

    FileUtils.install 'target/release/alacritty', "#{CREW_DEST_PREFIX}/bin/alacritty", mode: 0o755

    FileUtils.install 'extra/linux/Alacritty.desktop', "#{CREW_DEST_PREFIX}/share/applications/"
    FileUtils.install 'extra/linux/org.alacritty.Alacritty.appdata.xml', "#{CREW_DEST_PREFIX}/share/metainfo/org.alacritty.Alacritty.appdata.xml"
    FileUtils.install 'extra/completions/alacritty.bash', "#{CREW_DEST_PREFIX}/share/bash-completion/completions/alacritty"
    FileUtils.install 'extra/completions/_alacritty', "#{CREW_DEST_PREFIX}/share/zsh/site-functions/_alacritty"
    FileUtils.install 'extra/completions/alacritty.fish', "#{CREW_DEST_PREFIX}/share/fish/vendor_completions.d/alacritty.fish"
    FileUtils.install 'extra/logo/compat/alacritty-term.svg', "#{CREW_DEST_PREFIX}/share/pixmaps/Alacritty.svg"
  end
end
