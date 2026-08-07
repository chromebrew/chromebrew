require 'package'

class Opencode < Package
  description 'The open source coding agent.'
  homepage 'https://opencode.ai/'
  version '1.18.14'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/sst/opencode/releases/download/v#{version}/opencode-linux-x64.tar.gz"
  source_sha256 'f23980ba2aebfbfa53948e55e213d3f2a53740fd7326553828e89ad27e970572'

  no_compile_needed

  def self.install
    FileUtils.install 'opencode', "#{CREW_DEST_PREFIX}/bin/opencode", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'opencode' to get started.\n"
  end
end
