require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.73.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '684695517ea397a67f580c24714b65cbbf642db5aaaae2c7c7e0cdde7af8cf19',
     armv7l: '684695517ea397a67f580c24714b65cbbf642db5aaaae2c7c7e0cdde7af8cf19',
       i686: '1899b369b5a3d267c815d2cc62f0a644ad8137370beffd57001a0a1861bfcb73',
     x86_64: 'f4d8fcbe1ce0a3b503606c31adc956e372489d80b62d016e995a0d2c7fadcaad'
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
