require 'package'

class Pnpm < Package
  description 'Fast, disk space efficient package manager'
  homepage 'https://pnpm.io/'
  version '11.21.0'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/pnpm/pnpm/releases/download/v#{version}/pnpm-linux-x64.tar.gz"
  source_sha256 'aadc489ce4473c2af0fec06a5c19e113b5793d404eac49853c8153bf4b0d8263'

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
