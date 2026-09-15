require 'package'

class Opencode < Package
  description 'The open source coding agent.'
  homepage 'https://opencode.ai/'
  version '1.18.31'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/sst/opencode/releases/download/v#{version}/opencode-linux-x64.tar.gz"
  source_sha256 'e9312be75ed803b7415fc2aeabda1f4fe938912a39673762dc0c38c0e11ebde4'

  no_compile_needed

  def self.install
    FileUtils.install 'opencode', "#{CREW_DEST_PREFIX}/bin/opencode", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'opencode' to get started.\n"
  end
end
