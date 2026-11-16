require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.93.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '22de720b9c5e63763b833ce45aedb9d0b497a741e7e724dc7ac133ee57f64b06',
     armv7l: '22de720b9c5e63763b833ce45aedb9d0b497a741e7e724dc7ac133ee57f64b06',
       i686: '6b76e38536c8a3b8a5594d20f9504421dd5f9b7f67f1b96f6b11009ca1b76526',
     x86_64: 'e6e1152478d268616751ab6d56f2d9f48b2977dc842574c1e1fa833b4bea5f23'
  })

  depends_on 'py3_bcrypt'
  depends_on 'py3_cryptography'
  depends_on 'py3_pynacl'
  depends_on 'python3' => :logical
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
