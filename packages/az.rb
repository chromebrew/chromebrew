require 'package'

class Az < Package
  description 'The Azure CLI 2.0 is Azure\'s new command-line experience for managing Azure resources.'
  homepage 'https://github.com/Azure/azure-cli'
  version '2.0.41'
  source_url 'https://github.com/Azure/azure-cli/archive/azure-cli-2.0.41.tar.gz'
  source_sha256 'cb0db0d99ab89d347690c44f1d4af310517659670b4b7e1d87c55f9d75059516'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3' unless File.exists? "#{CREW_PREFIX}/bin/python"
  depends_on 'libffi'
  depends_on 'openssl'
  depends_on 'setuptools'

  def self.install
    system "pip install azure-cli -r requirements.txt --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end

  def self.postinstall
    puts
    puts "To add command completion, execute the following:".lightblue
    puts "echo 'source #{CREW_PREFIX}/share/azure-cli/az.completion' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
