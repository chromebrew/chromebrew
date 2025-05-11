require 'package'
require 'misc_functions'

class Ollama < Package
  description 'Get up and running with large language models.'
  homepage 'https://ollama.com/'
  version '0.6.8'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/ollama/ollama/releases/download/v#{version}/ollama-linux-amd64.tgz"
  source_sha256 '9f9ff52b8297d6e40904f22bac09eac587a05111762bf278359621fbdb53dbb9'

  no_compile_needed
  no_shrink
  # no_strip # ./usr/local/bin/ollama: 1: ./usr/local/bin/ollama: Syntax error: redirection unexpected (expecting ")")

  def self.preflight
    MiscFunctions.check_free_disk_space(3435973837)
  end

  def self.install
    FileUtils.install 'bin/ollama', "#{CREW_DEST_PREFIX}/bin/ollama", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'ollama' to get started.\n"
  end
end
