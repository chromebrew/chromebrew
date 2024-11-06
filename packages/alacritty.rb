# Adapted from Arch Linux alacritty PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/alacritty/trunk/PKGBUILD

require 'package'

class Alacritty < Package
  description 'A cross-platform, GPU-accelerated terminal emulator'
  homepage 'https://github.com/alacritty/alacritty'
  version '0.11.0'
  license 'Apache'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/alacritty/alacritty.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '24f808cdec4ef1a520d7b2526f3359324900656e4bea5b9fee9c77efc6e9ef63',
     armv7l: '24f808cdec4ef1a520d7b2526f3359324900656e4bea5b9fee9c77efc6e9ef63',
     x86_64: 'dd593610cbc27b8b1cece7dca3b73bb1194ae4b04a215eef85a229354fb6c62f'
  })

  depends_on 'fontconfig'
  depends_on 'ncurses'
  depends_on 'libxcb'
  depends_on 'rust' => :build
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libxcursor' # R
  depends_on 'libxi' # R

  def self.build
    system 'CARGO_INCREMENTAL=0 cargo build --release'
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_MAN_PREFIX}/man1
                         #{CREW_DEST_PREFIX}/share/appdata #{CREW_DEST_PREFIX}/share/doc/alacritty/example
                         #{CREW_DEST_PREFIX}/share/bash-completion/completions
                         #{CREW_DEST_PREFIX}/share/zsh/site-functions
                         #{CREW_DEST_PREFIX}/share/fish/vendor_completions.d
                         #{CREW_DEST_PREFIX}/share/pixmaps]
    FileUtils.install 'target/release/alacritty', "#{CREW_DEST_PREFIX}/bin/alacritty", mode: 0o755
    FileUtils.install 'extra/alacritty.man', "#{CREW_DEST_MAN_PREFIX}/man1/alacritty.1", mode: 0o644
    FileUtils.install 'extra/alacritty-msg.man', "#{CREW_DEST_MAN_PREFIX}/man1/alacritty-msg.1", mode: 0o644
    FileUtils.install 'extra/linux/org.alacritty.Alacritty.appdata.xml',
                      "#{CREW_DEST_PREFIX}/share/appdata/org.alacritty.Alacritty.appdata.xml", mode: 0o644
    FileUtils.install 'alacritty.yml', "#{CREW_DEST_PREFIX}/share/doc/alacritty/example/alacritty.yml", mode: 0o644
    FileUtils.install 'extra/completions/alacritty.bash',
                      "#{CREW_DEST_PREFIX}/share/bash-completion/completions/alacritty", mode: 0o644
    FileUtils.install 'extra/completions/_alacritty', "#{CREW_DEST_PREFIX}/share/zsh/site-functions/_alacritty",
                      mode: 0o644
    FileUtils.install 'extra/completions/alacritty.fish',
                      "#{CREW_DEST_PREFIX}/share/fish/vendor_completions.d/alacritty.fish", mode: 0o644
    FileUtils.install 'extra/logo/alacritty-term.svg', "#{CREW_DEST_PREFIX}/share/pixmaps/Alacritty.svg", mode: 0o644
  end
end
