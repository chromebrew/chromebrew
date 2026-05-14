require 'package'

class Ollama < Package
  description 'Get up and running with large language models.'
  homepage 'https://ollama.com/'
  version '0.23.3'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/ollama/ollama/releases/download/v#{version}/ollama-linux-amd64.tar.zst"
  source_sha256 '54a28dbc5266d0e6b514e8436d6cedf1bdd40902139b2a1945f6c2348d0ab8df'

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
