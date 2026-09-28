require 'package'

class Qwen < Package
  description 'An open-source AI coding agent that lives in your terminal.'
  homepage 'https://qwenlm.github.io/qwen-code-docs/en/users/overview'
  version '0.24.6'
  license 'Apache-2.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/QwenLM/qwen-code/releases/download/v#{version}/qwen-code-linux-x64.tar.gz"
  source_sha256 'e9ba9793a974cb259081ad44998bf3fe24e746ff5108860529968dbc910b7761'

  no_compile_needed

  def self.build
    File.write 'qwen.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/qwen
      bin/qwen "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/qwen"
    FileUtils.cp_r Dir['*'], "#{CREW_DEST_PREFIX}/share/qwen"
    FileUtils.install 'qwen.sh', "#{CREW_DEST_PREFIX}/bin/qwen", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'qwen' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.qwen")
  end
end
