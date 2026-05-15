require 'package'

class Make_cli < Package
  description 'A command-line tool for Make automation platform'
  homepage 'https://developers.make.com/make-cli'
  version '1.4.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/integromat/make-cli/releases/download/v#{version}/make-cli-linux-amd64.tar.gz"
  source_sha256 'ca0ef36dffdb3afd94bbdd85b6a24ab70d9a5d8705a1955b1b1603e4cca9a9bd'

  no_compile_needed

  def self.install
    FileUtils.install 'make-cli-linux-amd64', "#{CREW_DEST_PREFIX}/bin/make-cli", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'make-cli -h' to get started.\n"
  end
end
