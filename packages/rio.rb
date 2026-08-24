require 'package'

class Rio < Package
  description 'A hardware-accelerated GPU terminal emulator focusing to run in desktops and browsers.'
  homepage 'https://raphamorim.io/rio'
  version '0.5.26'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/raphamorim/rio.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'd95ba1916214bd0cc57eea4bd3e4ed8ab6bba52a9708a20452080fda5d62412a'
  })

  depends_on 'fontconfig' => :executable
  depends_on 'freetype' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'glslang' => :build
  depends_on 'harfbuzz' => :executable
  depends_on 'rust' => :build
  depends_on 'sommelier' => :logical
  depends_on 'wayland' # R

  def self.build
    system 'cargo build -p rioterm --release --no-default-features --features=x11,wayland'
  end

  def self.install
    FileUtils.install 'target/release/rio', "#{CREW_DEST_PREFIX}/bin/rio", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'rio' to get started.\n"
  end
end
