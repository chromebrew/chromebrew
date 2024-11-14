require 'package'

class Ollama < Package
  description 'Get up and running with large language models.'
  homepage 'https://ollama.com/'
  version '0.1.47'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/ollama/ollama/releases/download/v#{version}/ollama-linux-amd64"
  source_sha256 '4e51802b7a4b3591d1cd5999936e1fb95b6789477c866ef47ba3613f53da9713'

  no_compile_needed
  no_shrink
  # no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'ollama-linux-amd64', "#{CREW_DEST_PREFIX}/bin/ollama", mode: 0o755
  end
end
