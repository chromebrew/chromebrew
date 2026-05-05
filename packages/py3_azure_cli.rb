require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.86.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b82743f64cc7eb6e6b71eec12e8ebd3f8674d9c8f81f8fcd8dc130efa33046ad',
     armv7l: 'b82743f64cc7eb6e6b71eec12e8ebd3f8674d9c8f81f8fcd8dc130efa33046ad',
       i686: '5c0d16ee4c1b9b45e55449ee05c0de9cb413ec97ab9ed7760d6866e2eef2299c',
     x86_64: '75267bd0071636a5ae9c453a082baa281b0f6a684ede1082b5939277a1040a31'
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
