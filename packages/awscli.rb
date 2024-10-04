require 'buildsystems/pip'

class Awscli < Pip
  description 'Universal Command Line Interface for Amazon Web Services'
  homepage 'https://github.com/aws/aws-cli'
  version "1.35.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
     armv7l: 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
       i686: 'f5a69e7fc9a2e590c9259bcfa3c6c6e82d732b74fed5583d3ae954ac62ffcca1',
     x86_64: 'dbe54ab7e012af5496932508147df000cc16b35cf7e1bee549d3ec3ab65476ee'
  })

  depends_on 'groff'
  depends_on 'python3' => :build

  no_source_build

  pip_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    File.write "#{CREW_DEST_PREFIX}/etc/bash.d/aws", <<~AWSBASHRCEOF
      # Amazon Web Services CLI bash completion
      source #{CREW_PREFIX}/bin/aws_bash_completer
    AWSBASHRCEOF
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/zsh.d"
    File.write "#{CREW_DEST_PREFIX}/etc/zsh.d/aws", <<~AWSZSHRCEOF
      # Amazon Web Services CLI zsh completion
      source #{CREW_PREFIX}/bin/aws_zsh_completer.sh
    AWSZSHRCEOF
  end
end
