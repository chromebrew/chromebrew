require 'package'

class Pnpm < Package
  description 'Fast, disk space efficient package manager'
  homepage 'https://pnpm.io/'
  version '12.4.1'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/pnpm/pnpm/releases/download/v#{version}/pnpm-linux-x64.tar.gz"
  source_sha256 '66e9886299085dade56e203ae0e3586f35787f8801a68d33ec07ac17b0de2001'

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
