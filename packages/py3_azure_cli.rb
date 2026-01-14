require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.82.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '93594853301dd58bea0f14056bcc1249ccf929403bd5f51c2b9367aca73c0135',
     armv7l: '93594853301dd58bea0f14056bcc1249ccf929403bd5f51c2b9367aca73c0135',
       i686: '5cc7b87d7925ba24f83af55e3fceef41a957799887a192ef558dce80118201c0',
     x86_64: '618f48aa392191332d4cd575678b55a897782250f02f27d498837e1c75e0285a'
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
