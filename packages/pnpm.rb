require 'package'

class Pnpm < Package
  description 'Fast, disk space efficient package manager'
  homepage 'https://pnpm.io/'
  version '10.30.1'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/pnpm/pnpm/releases/download/v#{version}/pnpm-linux-x64"
  source_sha256 '44584d1bf4964eab9117484bbac165279f5584d743b98dfddb72f2cde5caff92'

  no_compile_needed

  def self.install
    FileUtils.install 'pnpm-linux-x64', "#{CREW_DEST_PREFIX}/bin/pnpm", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'pnpm' to get started.\n"
  end
end
