require 'buildsystems/pip'

class Awscli < Pip
  description 'Universal Command Line Interface for Amazon Web Services'
  homepage 'https://github.com/aws/aws-cli'
  version '1.34.18-py3.12'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
       i686: '04f662629e5ee3376cbc37dc5961daebd2aef5106eaa12f8f408e86a817051b5',
    aarch64: '6753114402b1f894ecb5b7f5c00e1cc1e90af624f59b98d7dd79b9928b2aea7e',
     armv7l: '6753114402b1f894ecb5b7f5c00e1cc1e90af624f59b98d7dd79b9928b2aea7e',
     x86_64: 'd145e4ff24d73d5ebf89ed0320c86350c3f54cf74237190ed4e905a23cd5d02b'
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
