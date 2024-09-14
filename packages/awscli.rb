require 'buildsystems/pip'

class Awscli < Pip
  description 'Universal Command Line Interface for Amazon Web Services'
  homepage 'https://github.com/aws/aws-cli'
  version '1.34.19-py3.12'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
       i686: '027eb2f4e0c980d2c4647ae9060857b455e0ccbf5773e983c8bfca2c3626ca9e',
    aarch64: '498daf5e18875fccac265fefefc55c4c546b10a1a3555b2def6dbd7f2dcaa02d',
     armv7l: '498daf5e18875fccac265fefefc55c4c546b10a1a3555b2def6dbd7f2dcaa02d',
     x86_64: '909cc6edc1beeb9d06df179bbd2bcdac96712944c2e60368aeee4551ec0ed996'
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
