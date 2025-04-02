require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.71.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3cdcf0c704dae4a71e9405ed8a922389927af325f62cae9809c259418282a38',
     armv7l: 'f3cdcf0c704dae4a71e9405ed8a922389927af325f62cae9809c259418282a38',
       i686: 'c63dec1942bc00e14dc180afe69a6ad0c06beb35f75e04af2b99c1c2d75a07ad',
     x86_64: '8c945a24c6fb1b43d187de887e600255506fbf53fe3b8e3ac74cdcc7a703a009'
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
