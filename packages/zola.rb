require 'package'

class Zola < Package
  description 'A fast static site generator'
  homepage 'https://www.getzola.org/'
  version '0.22.1'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/getzola/zola/releases/download/v#{version}/zola-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  source_sha256 '0ca09aa40376aaa9ddfb512ff9ad963262ef95edb0d0f2d5ec6961b6f5cf22ef'

  no_compile_needed

  def self.install
    FileUtils.install 'zola', "#{CREW_DEST_PREFIX}/bin/zola", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'zola' to get started.\n"
  end
end
