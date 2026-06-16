require 'package'

class Pnpm < Package
  description 'Fast, disk space efficient package manager'
  homepage 'https://pnpm.io/'
  version '11.7.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/pnpm/pnpm/releases/download/v#{version}/pnpm-linux-x64.tar.gz"
  source_sha256 '752e31654c6f24bc945db784d12831b80b29f533b43105575ce30dd3c8658609'

  no_compile_needed

  def self.install
    FileUtils.install 'pnpm', "#{CREW_DEST_PREFIX}/bin/pnpm", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'pnpm' to get started.\n"
  end
end
