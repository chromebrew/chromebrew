require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.88.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e2978c2c92bd6a74a366b2ff1b147c27b8e7d6be171ae117b406d2bf7b48b73',
     armv7l: '7e2978c2c92bd6a74a366b2ff1b147c27b8e7d6be171ae117b406d2bf7b48b73',
       i686: '7973b39e6d14792d0d5551cb83f2351d09bddd2f98a40dd39adcff444b799543',
     x86_64: '9b013ea95b09fcbcd610388d5ad3e8789afe42125d9ae4b4fbfa8805939618bf'
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
