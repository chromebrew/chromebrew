require 'package'

class Ollama < Package
  description 'Get up and running with large language models.'
  homepage 'https://ollama.com/'
  version '0.40.18'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/ollama/ollama/releases/download/v#{version}/ollama-linux-amd64.tar.zst"
  source_sha256 'b82649006cb5b54ed1237fa2d1a26a7f939a4fd03150033759acbff7ff315adf'

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
