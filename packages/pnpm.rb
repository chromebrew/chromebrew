require 'package'

class Pnpm < Package
  description 'Fast, disk space efficient package manager'
  homepage 'https://pnpm.io/'
  version '10.33.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/pnpm/pnpm/releases/download/v#{version}/pnpm-linux-x64"
  source_sha256 '8d4e8f7d778e8ac482022e2577011706a872542f6f6f233e795a4d9f978ea8b5'

  no_compile_needed

  def self.install
    FileUtils.install 'pnpm-linux-x64', "#{CREW_DEST_PREFIX}/bin/pnpm", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'pnpm' to get started.\n"
  end
end
