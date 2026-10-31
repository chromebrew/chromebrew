require 'package'

class Opencode < Package
  description 'The open source coding agent.'
  homepage 'https://opencode.ai/'
  version '2.2.4'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/sst/opencode/releases/download/v#{version}/opencode-linux-x64.tar.gz"
  source_sha256 '1b70ce4a88e27c3643c2bb61c757dfe173b4e3629926ce808d45f3774d87826e'

  no_compile_needed

  def self.install
    FileUtils.install 'opencode', "#{CREW_DEST_PREFIX}/bin/opencode", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'opencode' to get started.\n"
  end
end
