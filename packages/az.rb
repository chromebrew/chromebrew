require 'package'

class Az < Package
  description 'The Azure CLI 2.0 is Azure\'s new command-line experience for managing Azure resources.'
  homepage 'https://github.com/Azure/azure-cli'
  version '2.0.32'
  source_url 'https://github.com/Azure/azure-cli/archive/azure-cli-2.0.32.tar.gz'
  source_sha256 'e15fd9b22ab2933532b06d772f97c9bfb12cf9f8908aab48078a030eeee252b1'

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/az-2.0.32-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/az-2.0.32-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: '60a1e5f80401b760d5e20767a69b265de90ef791865862f87379214c61f521a1',
     x86_64: 'f469959218e5ad32c99748b41903403968bcf0c53ab7ff22f9fcda28aca421a1',
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"
  depends_on 'libffi'
  depends_on 'openssl'

  def self.install
    system "pip install setuptools"
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
