require 'package'

class Opencode < Package
  description 'The open source coding agent.'
  homepage 'https://opencode.ai/'
  version '1.18.34'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/sst/opencode/releases/download/v#{version}/opencode-linux-x64.tar.gz"
  source_sha256 '0f22479647226d1d2dd99595d20082ee7bda3870b62dc6a90b41efc1a71d7e9a'

  no_compile_needed

  def self.install
    FileUtils.install 'opencode', "#{CREW_DEST_PREFIX}/bin/opencode", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'opencode' to get started.\n"
  end
end
