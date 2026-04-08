require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.85.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f02514223edde48cbb13fab3e8929cda4287c64ee1453c686b9c6cc2ea7f5b6d',
     armv7l: 'f02514223edde48cbb13fab3e8929cda4287c64ee1453c686b9c6cc2ea7f5b6d',
       i686: '329a55db5dc21e1e19f7d080e542871427a9fb78a786a932aa2fe4c28357e3dd',
     x86_64: 'cfe522f0ed54f75208c30355d07204c800e3919b347bdc2fdfe889d1b7bd7a13'
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
