require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.84.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f798d1c2831350b61bac52c4835332a03bc35dd7455a0e1afef53b637238fe4',
     armv7l: '5f798d1c2831350b61bac52c4835332a03bc35dd7455a0e1afef53b637238fe4',
       i686: '29303f0d8545dfc35abe2d5e2303f0a2e6e74ce896a4c388f6212f3a95cca2a7',
     x86_64: '62f67e8b642ffa9b5ea809b82193d5b5eaedbfd21f7fcf86c5643790fb9d3810'
  })

  depends_on 'py3_bcrypt'
  depends_on 'py3_cryptography'
  depends_on 'py3_pynacl'
  depends_on 'python3'
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
