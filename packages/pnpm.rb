require 'package'

class Pnpm < Package
  description 'Fast, disk space efficient package manager'
  homepage 'https://pnpm.io/'
  version '10.30.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/pnpm/pnpm/releases/download/v#{version}/pnpm-linux-x64"
  source_sha256 '78d83aa009dc7e8d18faf5ea87e8cafed9601245f23757f00c3582284f54f793'

  no_compile_needed

  def self.install
    FileUtils.install 'pnpm-linux-x64', "#{CREW_DEST_PREFIX}/bin/pnpm", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'pnpm' to get started.\n"
  end
end
