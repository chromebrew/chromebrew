require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.79.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5fa522a41455eedef049a41e6d5a97574a7b516d1c2181008576983e90b6d3e6',
     armv7l: '5fa522a41455eedef049a41e6d5a97574a7b516d1c2181008576983e90b6d3e6',
       i686: 'd1531629a7d69ac0fd9bc2199a924a4f5b3a00c62ff2b62ab795eb0fbdcf776f',
     x86_64: 'c83935ed4cb100d973a5b46e61d547034f716b5efa0051dd66f7b56a6f2a33e1'
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
