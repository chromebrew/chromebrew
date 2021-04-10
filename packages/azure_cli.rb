require 'package'

class Azure_cli < Package
  description 'The Azure CLI 2.0 is Azure\'s new command-line experience for managing Azure resources.'
  homepage 'https://github.com/Azure/azure-cli'
  version '2.21.0'
  license 'MIT'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://github.com/Azure/azure-cli/archive/azure-cli-2.21.0.tar.gz'
    source_sha256 'bbe4a1f85418d239444717f2c9706a87f81fd2515bb0bb4b4e48548fd3e08caa'
  end

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @azurebashd = <<~AZUREEOF
      # Microsoft Azure CLI bash completion
      source #{CREW_PREFIX}/share/azure-cli/az.completion
    AZUREEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/az", @azurebashd)
  end
end
