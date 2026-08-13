require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.89.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6856094e8c398f2c8762f31d5b3c6d16b333d24bec8f011a95bb4120cb57691d',
     armv7l: '6856094e8c398f2c8762f31d5b3c6d16b333d24bec8f011a95bb4120cb57691d',
       i686: 'efe891a03b43f064f776a9772fb30c2cc6de75e3851d3217f8156fab743d2da7',
     x86_64: '88218cecf70809235c248db5d87f6cc58030acc49824231f767695a8fa975eef'
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
