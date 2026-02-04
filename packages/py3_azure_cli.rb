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
    aarch64: '9e34b8cd79d0a105cab4f12e2b28e96f1b70265690e01259aa8d214c5cd2184c',
     armv7l: '9e34b8cd79d0a105cab4f12e2b28e96f1b70265690e01259aa8d214c5cd2184c',
       i686: 'ee97982c8c0d29864067cae0688a0325d0db9113befbb62bee94b53bfec4f512',
     x86_64: 'a91181565768a355caff1c4c4435b6630eb23371ec3abc8cb65d02021da628a7'
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
