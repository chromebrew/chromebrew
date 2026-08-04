require 'package'

class Pnpm < Package
  description 'Fast, disk space efficient package manager'
  homepage 'https://pnpm.io/'
  version '11.20.0'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/pnpm/pnpm/releases/download/v#{version}/pnpm-linux-x64.tar.gz"
  source_sha256 'b4ad6ad2b21db2f8cd50af416c3aa148ba704c31c84893f465a770a01c2c4572'

  no_compile_needed

  def self.install
    Dir['**/*'].each do |x|
      FileUtils.install x, "#{CREW_DEST_PREFIX}/libexec/pnpm/#{x}" if File.file?(x)
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/libexec/pnpm/pnpm", "#{CREW_DEST_PREFIX}/bin/pnpm"
  end

  def self.postinstall
    ExitMessage.add "\nType 'pnpm' to get started.\n"
  end
end
