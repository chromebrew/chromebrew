require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.76.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2199a5e34d43da5f818de05ce755d58bc1b3925c797f4ae9f88fd7678fa88381',
     armv7l: '2199a5e34d43da5f818de05ce755d58bc1b3925c797f4ae9f88fd7678fa88381',
       i686: '29a4a2feb8d6745da70f1d4e1b08f6b2724c87898ff0f38cbdca15a940867036',
     x86_64: '1b0569c285e76725c18f90df491c97a624049b288e4f0fc90b0249c220edcd6a'
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
