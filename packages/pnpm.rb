require 'package'

class Pnpm < Package
  description 'Fast, disk space efficient package manager'
  homepage 'https://pnpm.io/'
  version '10.29.3'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/pnpm/pnpm/releases/download/v#{version}/pnpm-linux-x64"
  source_sha256 '2fc98db127c611be0c110af11b5b72759f7d736893dddc81df73b7b59b30f15a'

  no_compile_needed

  def self.install
    FileUtils.install 'pnpm-linux-x64', "#{CREW_DEST_PREFIX}/bin/pnpm", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'pnpm' to get started.\n"
  end
end
