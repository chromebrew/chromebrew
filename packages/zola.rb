require 'package'

class Zola < Package
  description 'A fast static site generator'
  homepage 'https://www.getzola.org/'
  version '0.23.3'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/getzola/zola/releases/download/v#{version}/zola-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  source_sha256 'f07c92607e5745268b576bd325ceef3a582aada253bb64db8d92a8a85303d958'

  no_compile_needed

  def self.install
    FileUtils.install 'zola', "#{CREW_DEST_PREFIX}/bin/zola", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'zola' to get started.\n"
  end
end
