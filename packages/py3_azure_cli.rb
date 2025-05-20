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
    aarch64: 'a4a40910e330bc797451b5a7d42d54c5de9eebac5f5f18e2a86388c3109f4ceb',
     armv7l: 'a4a40910e330bc797451b5a7d42d54c5de9eebac5f5f18e2a86388c3109f4ceb',
       i686: '1899b369b5a3d267c815d2cc62f0a644ad8137370beffd57001a0a1861bfcb73',
     x86_64: '2890116c568412b537d04951dc5d880dff225394b8944f4922314aee091a48b7'
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
