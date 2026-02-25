require 'package'

class Pnpm < Package
  description 'Fast, disk space efficient package manager'
  homepage 'https://pnpm.io/'
  version '10.30.2'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/pnpm/pnpm/releases/download/v#{version}/pnpm-linux-x64"
  source_sha256 '8e0953608faa1df32187e7a8ff73e2c148b28b52c3860e9bde0c13d08da38bc9'

  no_compile_needed

  def self.install
    FileUtils.install 'pnpm-linux-x64', "#{CREW_DEST_PREFIX}/bin/pnpm", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'pnpm' to get started.\n"
  end
end
