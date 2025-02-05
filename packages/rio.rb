require 'package'

class Rio < Package
  description 'A hardware-accelerated GPU terminal emulator focusing to run in desktops and browsers.'
  homepage 'https://raphamorim.io/rio'
  version '0.2.5'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/raphamorim/rio.git'
  git_hashtag "v#{version}"

  depends_on 'rust' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'wayland' # R
  depends_on 'sommelier' # R

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
