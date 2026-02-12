require 'buildsystems/pip'

class Awscli < Pip
  description 'Universal Command Line Interface for Amazon Web Services'
  homepage 'https://github.com/aws/aws-cli'
  version "1.44.37-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8eafc358acebd2b1f162291ec30ebf4b5b17e3d8fdc8013501717adac4b633a2',
     armv7l: '8eafc358acebd2b1f162291ec30ebf4b5b17e3d8fdc8013501717adac4b633a2',
       i686: '8be23a5d5779e7862eee0fc3923ce3c61fcec05ab8676dcbb74888e945c120e5',
     x86_64: '969dabda3cc03bd0982f83e3be60fbab2f847892b0481dd1952d9c3387413cb3'
  })

  binary_sha256({
    aarch64: '2a7d1559bb7c4d8c219833c0b10fcfdae24536ad8f331d09182eea816fa18c49',
     armv7l: '2a7d1559bb7c4d8c219833c0b10fcfdae24536ad8f331d09182eea816fa18c49',
       i686: '15ae900e0a65f970af4a1cf51f6a2d8c61d68409842b17017414bf0a4ef2c77d',
     x86_64: '730d4beee8d70a0674037d4d09eb4f0811dcdc75294415139714cb67c51c850f'
  })

  depends_on 'groff' # R
  depends_on 'py3_botocore' # R
  depends_on 'py3_docutils' # R
  depends_on 'py3_jmespath' # R
  depends_on 'py3_pyasn1' # R
  depends_on 'py3_python_dateutil' # R
  depends_on 'py3_rsa' # R
  depends_on 'py3_s3transfer' # R
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
