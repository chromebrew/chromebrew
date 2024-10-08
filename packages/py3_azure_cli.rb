require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.65.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f8ac5343745a085289abfa93cb18da98b6cd98157ffba22390bb3fefae55556c',
     armv7l: 'f8ac5343745a085289abfa93cb18da98b6cd98157ffba22390bb3fefae55556c',
       i686: 'a483f54003b50262129bbf123d3f734d85c6f22087fc982a7c071bf2d254eeed',
     x86_64: '15b8cf2a60ce9cbe38cdcdfc7bc0aa0539869680a698e1ef7461ce362357ca94'
  })

  depends_on 'python3'
  depends_on 'py3_cryptography'
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
