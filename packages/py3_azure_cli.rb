require 'buildsystems/pip'

class Py3_azure_cli < Pip
  description 'Next generation multi-platform command line experience for Azure.'
  homepage 'https://pypi.org/project/azure-cli/'
  @_ver = '2.53.1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3'
  depends_on 'py3_cryptography'
  depends_on 'rust' => :build

  no_compile_needed

  pip_install_extras <<~EXTRAS_EOF
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @azureenv = <<~AZUREEOF
      # Microsoft Azure CLI bash completion
      source #{CREW_PREFIX}/bin/az.completion.sh
    AZUREEOF
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/az", @azureenv)
  EXTRAS_EOF

  def self.postinstall
    ExitMessage.add "\nTo finish the installation, please execute the following:\nsource ~/.bashrc".lightblue, print_last: true
  end
end
