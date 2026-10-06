require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.91.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b4e1759905cf1fb807a2385b24393d84268a985f2158d7bf08a13c874386c043',
     armv7l: 'b4e1759905cf1fb807a2385b24393d84268a985f2158d7bf08a13c874386c043',
       i686: '83198ef1ab035efd3649047daecdcaf190ae662adff4eb7adc523d03f40808e6',
     x86_64: 'fbcd2453d8ab84348ccdd0421b24a0acfa68e3d233a43c7996cd330b50e9c3e9'
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
