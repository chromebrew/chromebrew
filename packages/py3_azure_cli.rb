require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.81.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '839b599a5645e816fd04fb0ba5f9521b747bd5c400d07c33996d16a50f46e0a3',
     armv7l: '839b599a5645e816fd04fb0ba5f9521b747bd5c400d07c33996d16a50f46e0a3',
       i686: '7e026576e9f590c9ddcded0d0ad64c9558edc1a54d23f84fcb591bcb96a28dd1',
     x86_64: '6a1596a85400966005b976871d35fef051ba08b3737df4d4dbb499d157902a0a'
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
