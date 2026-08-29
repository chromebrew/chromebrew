require 'package'

class Opencode < Package
  description 'The open source coding agent.'
  homepage 'https://opencode.ai/'
  version '1.18.25'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/sst/opencode/releases/download/v#{version}/opencode-linux-x64.tar.gz"
  source_sha256 '58a3729a6f3432dd6d2917fcc4a949788891a035818646ad480e12c947f56e78'

  no_compile_needed

  def self.install
    FileUtils.install 'opencode', "#{CREW_DEST_PREFIX}/bin/opencode", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'opencode' to get started.\n"
  end
end
