require 'package'

class Pnpm < Package
  description 'Fast, disk space efficient package manager'
  homepage 'https://pnpm.io/'
  version '11.8.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/pnpm/pnpm/releases/download/v#{version}/pnpm-linux-x64.tar.gz"
  source_sha256 '86b9aa5362b06cc61f5e829e41614ffda2fbda09993b8e84176feaa3c97b9532'

  no_compile_needed

  def self.install
    FileUtils.install 'pnpm', "#{CREW_DEST_PREFIX}/bin/pnpm", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'pnpm' to get started.\n"
  end
end
