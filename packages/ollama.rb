require 'package'

class Ollama < Package
  description 'Get up and running with large language models.'
  homepage 'https://ollama.com/'
  version '0.30.6'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/ollama/ollama/releases/download/v#{version}/ollama-linux-amd64.tar.zst"
  source_sha256 'a6d29b68cb7f74023ad1fbb86330d051ccdd1321a79ea12257b8b9409b095930'

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

  def self.postremove
    Package.agree_to_remove("#{HOME}/.ollama")
  end
end
