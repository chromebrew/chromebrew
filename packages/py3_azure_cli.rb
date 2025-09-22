require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.77.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9eb9d29337d3d1fa56172cbef50cbc0798085561bbb91cdeb578e776adfe6dab',
     armv7l: '9eb9d29337d3d1fa56172cbef50cbc0798085561bbb91cdeb578e776adfe6dab',
       i686: '8908b1e56f37ed6bb6f4b55590056fcbde98c7f95de55a5b98c52c7cc6dee87b',
     x86_64: 'a4caca3517f24a01d45b3b72ebff6e5aca9ac43f42bb11aec76381054035979f'
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
