require 'package'

class Bun < Package
  description 'Incredibly fast JavaScript runtime, bundler, test runner, and package manager – all in one'
  homepage 'https://bun.sh/'
  version '1.1.12'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'SKIP'

  no_compile_needed

  def self.install
    ENV['BUN_INSTALL'] = CREW_DEST_PREFIX.to_s
    system "curl -fsSL https://bun.sh/install | bash -s 'bun-v#{version}'"
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/bun", "#{CREW_DEST_PREFIX}/bin/bunx"
  end

  def self.postinstall
    ExitMessage.add "\nType 'bun' to get started.\n".lightblue
  end
end
