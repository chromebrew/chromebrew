require 'buildsystems/pip'

class Awscli < Pip
  description 'Universal Command Line Interface for Amazon Web Services'
  homepage 'https://github.com/aws/aws-cli'
  version "1.45.24-#{CREW_PY_VER}"
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
    aarch64: '4803a8bad3b97cf9c82e7e5126d9f1ddbe881a7fa201508034e1c1eedf27bdb5',
     armv7l: '4803a8bad3b97cf9c82e7e5126d9f1ddbe881a7fa201508034e1c1eedf27bdb5',
       i686: '6405ce454276dc8cd7ea669220f9dc5affa49c800436899edf1f77410d866b3b',
     x86_64: '48719bc5cd16658a2a1c6096a03daf933a679c982af87768f01eb5d7a1982982'
  })

  depends_on 'groff' # R
  depends_on 'py3_botocore' # R
  depends_on 'py3_docutils' # R
  depends_on 'py3_jmespath' # R
  depends_on 'py3_pyasn1' # R
  depends_on 'py3_python_dateutil' # R
  depends_on 'py3_rsa' # R
  depends_on 'py3_s3transfer' # R
  depends_on 'python3' => :logical

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
