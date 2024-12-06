require 'buildsystems/pip'

class Awscli < Pip
  description 'Universal Command Line Interface for Amazon Web Services'
  homepage 'https://github.com/aws/aws-cli'
  version "1.36.17-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52d621ed859483974ef76af94954fb29be20f670a9ee05e85bf25dd3d7c92bc6',
     armv7l: '52d621ed859483974ef76af94954fb29be20f670a9ee05e85bf25dd3d7c92bc6',
       i686: '49d8480337b33a2017cd94c4de667c007f2e543ce4e83b836a90f1c889c60cff',
     x86_64: 'd82d0046dbc1af8c669d0d55cd3c645aab45011c189ddcc414901d8fb624a271'
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
