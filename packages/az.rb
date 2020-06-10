require 'package'

class Az < Package
  description 'The Azure CLI 2.0 is Azure\'s new command-line experience for managing Azure resources.'
  homepage 'https://github.com/Azure/azure-cli'
  version '2.0.46'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://github.com/Azure/azure-cli/archive/azure-cli-2.0.46.tar.gz'
    source_sha256 '9a571e16e832614a064311dffea884ab4ae4c2739010b58c34fb2b190484d41c'
  end

  binary_url ({
      i686: 'https://dl.bintray.com/chromebrew/chromebrew/az-2.0.46-chromeos-i686.tar.xz',
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/az-2.0.46-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
      i686: 'f94d828a2eac6c69ec330f2434e90de97f77c19e5de09c6370e1f4ecf53792da',
    x86_64: 'e21a228cfaf6d85c0407451796c869a7a20da8ccd8de15380a28c1850c2e4347',
  })

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
