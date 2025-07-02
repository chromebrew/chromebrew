require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version "2.75.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44dc0f3ee812bdc094dca83d75c9314110c9b895b37c93985b52021d0b3a2af6',
     armv7l: '44dc0f3ee812bdc094dca83d75c9314110c9b895b37c93985b52021d0b3a2af6',
       i686: '0f116584de82dcbb15d0e3df1082a0e534960274281adca4dd0bf3b80d8c6921',
     x86_64: '253c26ed3518568388b91333d524bc5b4f46de01d14c800ddac2d9f12ad5f479'
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
