require 'buildsystems/pip'

class Awscli < Pip
  description 'Universal Command Line Interface for Amazon Web Services'
  homepage 'https://github.com/aws/aws-cli'
  version "1.34.28-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '627d8a0ed4021872f48d986fd0969272e3d1b1e91ca143526bd46c899857c05b',
     armv7l: '627d8a0ed4021872f48d986fd0969272e3d1b1e91ca143526bd46c899857c05b',
       i686: '7ee95c0821849739b70d8e0fb68c87bad12f8b880618e3e1a51b42f688cb7b9c',
     x86_64: '5d44025832a7ad755abfa2036bd97f8f81ea33559f758b132d8016cc235ecc1c'
  })

  binary_sha256({
    aarch64: '627d8a0ed4021872f48d986fd0969272e3d1b1e91ca143526bd46c899857c05b',
     armv7l: '627d8a0ed4021872f48d986fd0969272e3d1b1e91ca143526bd46c899857c05b',
       i686: '7ee95c0821849739b70d8e0fb68c87bad12f8b880618e3e1a51b42f688cb7b9c',
     x86_64: '5d44025832a7ad755abfa2036bd97f8f81ea33559f758b132d8016cc235ecc1c'
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
