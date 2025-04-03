require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.71.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3cdcf0c704dae4a71e9405ed8a922389927af325f62cae9809c259418282a38',
     armv7l: 'f3cdcf0c704dae4a71e9405ed8a922389927af325f62cae9809c259418282a38',
       i686: '1fba67d3d12494252c3d293b5fbb47ae9158515f9baed8dedde7c663867455e8',
     x86_64: '93ee8abe5b6d6a5288f830a70b6b6c6c5696f18be50dc50441398a47fc65a5b6'
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
