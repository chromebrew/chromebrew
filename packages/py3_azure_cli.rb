require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.89.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '109e5e0cb0cc18b989ab7811e9acafd92f203fb06b9119426a041066ecce4942',
     armv7l: '109e5e0cb0cc18b989ab7811e9acafd92f203fb06b9119426a041066ecce4942',
       i686: '9ff934ef6815ad5eac48f4177ea0ddb34419c2cb5b586eca75f98a3c8d7e3eac',
     x86_64: 'ebd438410f07a770e63d0b0e943dc4ccb1b63486da76ccfad22f2de1629a67eb'
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
