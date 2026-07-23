require 'buildsystems/pip'

class Awscli < Pip
  description 'Universal Command Line Interface for Amazon Web Services'
  homepage 'https://github.com/aws/aws-cli'
  version "1.45.54-#{CREW_PY_VER}"
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
    aarch64: '4c14d0c6616dbb688d08a22bcbd4a958057e68a0f8977bb0639488480397c474',
     armv7l: '4c14d0c6616dbb688d08a22bcbd4a958057e68a0f8977bb0639488480397c474',
       i686: 'e69ad94424cf306cf939b12e278234f9b4227bd9cac3427db40b06ffb0762269',
     x86_64: '5cac5cdeab0c052a86b72455abb2149f3f54d1dd2063074c82618eb6823efe80'
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
