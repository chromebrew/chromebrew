require 'package'

class Bun < Package
  description 'Incredibly fast JavaScript runtime, bundler, test runner, and package manager – all in one'
  homepage 'https://bun.sh/'
  version '1.2.19'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'SKIP'

  no_compile_needed
  no_shrink

  def self.install
    system "curl -fsSL https://bun.sh/install | BUN_INSTALL='#{CREW_DEST_PREFIX}' bash -s 'bun-v#{version}'"
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/bun", "#{CREW_DEST_PREFIX}/bin/bunx"
  end

  def self.postinstall
    ExitMessage.add "\nType 'bun' to get started.\n"
  end
end
