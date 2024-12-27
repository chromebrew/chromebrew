require 'buildsystems/pip'

class Awscli < Pip
  description 'Universal Command Line Interface for Amazon Web Services'
  homepage 'https://github.com/aws/aws-cli'
  version "1.36.29-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '57dbfba1c80f566f08e368897ff0f8311d16444a36ee7cd46eeea53663f6d83d',
     armv7l: '57dbfba1c80f566f08e368897ff0f8311d16444a36ee7cd46eeea53663f6d83d',
       i686: '30bc3622b62c13cb05d901da7ffe13fd7a57aa4544471db7461e876ed5ddfee3',
     x86_64: 'cebf2f507ba54db7920c75a5f2ea6331118c619be5afac3a7bdf5171a468ba46'
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
