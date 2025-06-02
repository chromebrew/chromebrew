require 'package'

class Zola < Package
  description 'A fast static site generator'
  homepage 'https://www.getzola.org/'
  version '0.20.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/getzola/zola/releases/download/v#{version}/zola-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  source_sha256 'ca7ed5b33a739c5b5b35a0e207e5c3578a652cd12b61c675763b3ff34c322d08'

  no_compile_needed

  def self.install
    FileUtils.install 'zola', "#{CREW_DEST_PREFIX}/bin/zola", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'zola' to get started.\n"
  end
end
