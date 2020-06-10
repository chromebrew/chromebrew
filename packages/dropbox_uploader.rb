require 'package'

class Dropbox_uploader < Package
  description 'Dropbox Uploader is a BASH script which can be used to upload, download, list or delete files from Dropbox, an online file sharing, synchronization and backup service.'
  homepage 'https://github.com/andreafabrizi/Dropbox-Uploader'
  version '1.0'
  compatibility 'all'
  source_url 'https://github.com/andreafabrizi/Dropbox-Uploader/archive/1.0.tar.gz'
  source_sha256 '8c9be8bd38fb3b0f0b4d1a863132ad38c8299ac62ecfbd1e818addf32b48d84c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dropbox_uploader-1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dropbox_uploader-1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dropbox_uploader-1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dropbox_uploader-1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1a69021e4219a9dca4b90e3b5f1a6b6b31b426f6c64e359148c1c0f7a376e260',
     armv7l: '1a69021e4219a9dca4b90e3b5f1a6b6b31b426f6c64e359148c1c0f7a376e260',
       i686: '8d2c53ab15a7ce7d6bff02c8409f26b5b07b81f425bfe59170ee9d76d59ef49a',
     x86_64: 'de141ac2bbc1a53d30776f5a280af3733222a92ca09465f13ea5b9d6000b2731',
  })

  depends_on 'curl'

  def self.install
    system "sed -i 's,dropbox_uploader.sh,dropbox_uploader,g' dropShell.sh"
    system "chmod +x dropShell.sh"
    system "chmod +x dropbox_uploader.sh"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp dropShell.sh #{CREW_DEST_PREFIX}/bin/dropshell"
    system "cp dropbox_uploader.sh #{CREW_DEST_PREFIX}/bin/dropbox_uploader"
    puts ""
    puts "Type 'dropbox_uploader' and follow the instructions to finish the installation.".lightblue
    puts "To execute The Interactive Dropbox SHELL, type 'dropshell'.".lightblue
    puts ""
  end
end
