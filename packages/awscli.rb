require 'buildsystems/pip'

class Awscli < Pip
  description 'Universal Command Line Interface for Amazon Web Services'
  homepage 'https://github.com/aws/aws-cli'
  version "1.35.18-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0aa803f22aa24ad0d7bf53a72a949b314b051dc4731413213e4ef523d205b7ca',
     armv7l: '0aa803f22aa24ad0d7bf53a72a949b314b051dc4731413213e4ef523d205b7ca',
       i686: '290db1e613a8c59836136fdb4af63944f862faac95782d6d5732c2462de1eda2',
     x86_64: 'ed8c8392f836729a4d409f1e8281e6e29d10d4c066c97d4873e2d14d7aecd069'
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
