require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.66.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eeb9489d8b0881ed8da7172b8c89c26aeac3969c6ed46ea1dfb6086ad876f91b',
     armv7l: 'eeb9489d8b0881ed8da7172b8c89c26aeac3969c6ed46ea1dfb6086ad876f91b',
       i686: '47a77b29a8e0eed8c91485acf5f56e00d763c9dfe4c1eba704e5b2c267f62b61',
     x86_64: '6245f2c96e250979b54739369e9e744c98faf1b0ff09fd4c5268c18080266a90'
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
