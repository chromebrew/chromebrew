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
    aarch64: 'd4bcb4284c0fdaa8a8ffd8b23ac8ed1affe0946b6949aa44c1bb2a5018ffdbd5',
     armv7l: 'd4bcb4284c0fdaa8a8ffd8b23ac8ed1affe0946b6949aa44c1bb2a5018ffdbd5',
       i686: 'b21183c6edf0da9f1856cb924c5919eecbba11d61541a2d0a4e5b2714e65666d',
     x86_64: 'e11410e2da8d1c83c373329135ee9062a08cfd5daeeabdd8b0051c2ff68653d9'
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
