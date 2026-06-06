require 'package'

class Pnpm < Package
  description 'Fast, disk space efficient package manager'
  homepage 'https://pnpm.io/'
  version '11.5.2'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/pnpm/pnpm/releases/download/v#{version}/pnpm-linux-x64.tar.gz"
  source_sha256 '2033a702618c8576dc6bb0f6adb3a67ab506031351ddd59ca50d1bcaf5d13dc5'

  no_compile_needed

  def self.install
    FileUtils.install 'pnpm', "#{CREW_DEST_PREFIX}/bin/pnpm", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'pnpm' to get started.\n"
  end
end
