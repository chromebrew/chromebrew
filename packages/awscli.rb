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
    aarch64: '48380a1e3c317d1ee4cdb519c52954be572092472745a14824c6c3ae85b0ebee',
     armv7l: '48380a1e3c317d1ee4cdb519c52954be572092472745a14824c6c3ae85b0ebee',
       i686: 'b30c33d6b77e961be8212a54b0be516666473897e28da51ceed45e8e9bdca60d',
     x86_64: 'a20bce9f9b9efee779d5fa5717ea21594b9dd5de06321a239777ff2fa18ea1ae'
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
