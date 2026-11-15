require 'package'

class Pnpm < Package
  description 'Fast, disk space efficient package manager'
  homepage 'https://pnpm.io/'
  version '12.21.0'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/pnpm/pnpm/releases/download/v#{version}/pnpm-linux-x64.tar.gz"
  source_sha256 '84c4773bcf4a217f4083cd7b2a91e4cee6103cf42426c1282ef37d308f55a410'

  no_compile_needed

  def self.install
    Dir['**/*'].each { FileUtils.install it, "#{CREW_DEST_PREFIX}/libexec/pnpm/#{it}" if File.file?(it) }
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/libexec/pnpm/pnpm", "#{CREW_DEST_PREFIX}/bin/pnpm"
  end

  def self.postinstall
    ExitMessage.add "\nType 'pnpm' to get started.\n"
  end
end
