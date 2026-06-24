require 'package'

class Pnpm < Package
  description 'Fast, disk space efficient package manager'
  homepage 'https://pnpm.io/'
  version '11.9.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/pnpm/pnpm/releases/download/v#{version}/pnpm-linux-x64.tar.gz"
  source_sha256 '8d987d82585453bcf260ea5d0bae346d298f1a5e71bcde8d99976521408ad895'

  no_compile_needed

  def self.install
    FileUtils.install 'pnpm', "#{CREW_DEST_PREFIX}/bin/pnpm", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'pnpm' to get started.\n"
  end
end
