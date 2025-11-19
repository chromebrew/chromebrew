require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.80.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '88469b19b74bae4e97ee15507b5427d3002a089e16ccd6659b43ee60414d75b7',
     armv7l: '88469b19b74bae4e97ee15507b5427d3002a089e16ccd6659b43ee60414d75b7',
       i686: '23180f26ddd1b9811d96fe811b4f9d16b6454565871737499ba0dd23d44a030f',
     x86_64: '4c1b658652957164aea88295baf7b92af9f5ab3c3fe037583785a7f27af9b54c'
  })

  depends_on 'python3'
  depends_on 'py3_bcrypt'
  depends_on 'py3_cryptography'
  depends_on 'py3_pynacl'
  depends_on 'rust' => :build

  no_source_build
  print_source_bashrc

  pip_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @azureenv = <<~AZUREEOF
      # Microsoft Azure CLI bash completion
      source #{CREW_PREFIX}/bin/az.completion.sh
    AZUREEOF
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/az", @azureenv)
  end
end
