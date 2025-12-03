require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.81.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9adea08ac4416cb14ad88e976cfcd941772792d216e39070540da7dcd128c0a6',
     armv7l: '9adea08ac4416cb14ad88e976cfcd941772792d216e39070540da7dcd128c0a6',
       i686: 'f421ecbfdeaeecb40a4ec5243af79ac38a2470b06eb6b71b03de94b077b625a4',
     x86_64: 'b7628c309cc2d998e962b4c58ab447e15d9bbaca4e30b11c2be0242b13f875f0'
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
