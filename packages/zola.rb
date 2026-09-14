require 'package'

class Zola < Package
  description 'A fast static site generator'
  homepage 'https://www.getzola.org/'
  version '0.23.6'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/getzola/zola/releases/download/v#{version}/zola-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  source_sha256 '8f5132b3522412d04e395e0b25f6d68613ad272a873e54a2b3ebf664873024a4'

  no_compile_needed

  def self.install
    FileUtils.install 'zola', "#{CREW_DEST_PREFIX}/bin/zola", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'zola' to get started.\n"
  end
end
