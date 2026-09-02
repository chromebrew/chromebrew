require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.90.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f82b44e97e2cbf493eadadaeea76fdf40078e712c4c5a6c28b388fdea0ab74ff',
     armv7l: 'f82b44e97e2cbf493eadadaeea76fdf40078e712c4c5a6c28b388fdea0ab74ff',
       i686: '11feb1536a624494b840e86dd8797a7a77bcb03b5fbfa106eca2bbd447cf7997',
     x86_64: '5e7be86270ca50913d7c88c78e02c5769cbc26c2dd351993f195662983cfb754'
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
