# Adapted from Arch Linux alacritty PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/alacritty/trunk/PKGBUILD

require 'package'

class Alacritty < Package
  description 'A cross-platform, GPU-accelerated terminal emulator'
  homepage 'https://github.com/alacritty/alacritty'
  version '0.16.1'
  license 'Apache'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/alacritty/alacritty.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e5a1d61d4ee4ceccc36fe873f4742664f1fa6a0c240a9f35e66b3817c54f5a08',
     armv7l: 'e5a1d61d4ee4ceccc36fe873f4742664f1fa6a0c240a9f35e66b3817c54f5a08',
     x86_64: '91a290725efad5d27126a338e445e31cd44d399889e8a130d0d01197d655b392'
  })

  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libxcb' # R
  depends_on 'libxcursor' # R
  depends_on 'libxi' # R
  depends_on 'libxkbcommon' # R
  depends_on 'ncurses' # R
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
