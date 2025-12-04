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
    aarch64: 'e7a7994d89c1b94c445e2f66e4cfb769ff3f2ce4e3b348b166396b33d2f183fb',
     armv7l: 'e7a7994d89c1b94c445e2f66e4cfb769ff3f2ce4e3b348b166396b33d2f183fb',
       i686: '7e026576e9f590c9ddcded0d0ad64c9558edc1a54d23f84fcb591bcb96a28dd1',
     x86_64: 'c5ff98636e92b301c64b23c371da3bc1ea9a6516e6117e0e3852c83b2191a0b9'
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
