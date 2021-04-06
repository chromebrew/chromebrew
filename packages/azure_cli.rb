# This package is left untouched, except upgrades, as many changes are in #5503

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

  def self.install
    system "pip install azure-cli -r requirements.txt --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system "chmod +x #{CREW_DEST_PREFIX}/bin/az"
  end

  def self.postinstall
    puts
    puts "To add command completion, execute the following:".lightblue
    puts "echo 'source #{CREW_PREFIX}/share/azure-cli/az.completion' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
