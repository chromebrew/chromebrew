require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.74.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44dc0f3ee812bdc094dca83d75c9314110c9b895b37c93985b52021d0b3a2af6',
     armv7l: '44dc0f3ee812bdc094dca83d75c9314110c9b895b37c93985b52021d0b3a2af6',
       i686: '7115e8c614d335f50f24a65bfd4b7d17a0fbaf771ed1fc207de901bf22920018',
     x86_64: 'b4cdc19aa5d595915a8c669d61e05a9a1a65583dbdaa128a9ae3b5e1cc553ee7'
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
