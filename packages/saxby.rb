require 'package'

class Saxby < Package
  description 'Local-first LLM router for Ollama and OpenAI-compatible backends.'
  homepage 'https://saxby.tools/'
  version '0.9.10'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  source_url "https://github.com/saxby-tools/saxby/releases/download/v#{version}/saxby-#{version}-linux-x64.tar.gz"
  git_hashtag "v#{version}"

  depends_on 'ollama' => :logical

  no_compile_needed
  print_source_bashrc

  def self.install
    FileUtils.install 'saxby', "#{CREW_DEST_PREFIX}/bin/saxby", mode: 0o755
    FileUtils.install 'saxbyd', "#{CREW_DEST_PREFIX}/bin/saxbyd", mode: 0o755
    FileUtils.install 'completions/saxby.bash', "#{CREW_DEST_PREFIX}/etc/env.d/saxby.bash", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nType 'saxby' to get started.\n"
  end
end
