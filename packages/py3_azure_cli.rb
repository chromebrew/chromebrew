require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.83.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb1a7e3523e38614a1d572e709f03ff37f220213a4c882ca06c74bf363aca211',
     armv7l: 'cb1a7e3523e38614a1d572e709f03ff37f220213a4c882ca06c74bf363aca211',
       i686: '6831c2736414c9ddac97f2555dd45cbceba130ac058c01661b3320f23f5c080a',
     x86_64: 'd8e7ed23e56dbd137879fe3b39250db12efb306f7f2d588119d7f1f42996b4ec'
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
