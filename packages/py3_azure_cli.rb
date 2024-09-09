require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  version '2.64.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf77aa7d672f682681848a0d62b869878d6d4f96537ca7c1cc108684f8f0ec28',
     armv7l: 'cf77aa7d672f682681848a0d62b869878d6d4f96537ca7c1cc108684f8f0ec28',
       i686: '34499bff31dac675b710e4d51a672b61735e650e4f46f4d7be7d36a3a08d6a44',
     x86_64: '9becb82e883eaa87bf6865fe400d37160fd81e3bc734789c3aa882b7ead4ed00'
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
