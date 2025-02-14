require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.69.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8afddb13a8a0d3a73593c5051b0d36b15b5a18f1b15d46516926436fc3ec00fe',
     armv7l: '8afddb13a8a0d3a73593c5051b0d36b15b5a18f1b15d46516926436fc3ec00fe',
       i686: '7107a7326ef3a764cbbaeb9e0646e7f2f972cecb11c3283fa56aa336c3c4f8dc',
     x86_64: 'fd8473ad60acdbd3fd0ca911bc09e1d3ff0aa0fb73b37f51ace45fb794ac8e6a'
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
