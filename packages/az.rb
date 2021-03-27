require 'package'

class Az < Package
  description 'The Azure CLI 2.0 is Azure\'s new command-line experience for managing Azure resources.'
  homepage 'https://github.com/Azure/azure-cli'
  version '2.0.46-1'
  license 'MIT'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://github.com/Azure/azure-cli/archive/azure-cli-2.0.46.tar.gz'
    source_sha256 '9a571e16e832614a064311dffea884ab4ae4c2739010b58c34fb2b190484d41c'
  end

  def self.install
    system "pip install azure-cli -r requirements.txt --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system "chmod +x #{CREW_DEST_PREFIX}/bin/az"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @env = <<~EOF
      # Microsoft Azure CLI bash completion
      source #{CREW_PREFIX}/share/azure-cli/az.completion
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/az", @env)
  end
end
