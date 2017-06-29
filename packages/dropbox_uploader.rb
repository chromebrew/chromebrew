require 'package'

class Dropbox_uploader < Package
  description 'Dropbox Uploader is a BASH script which can be used to upload, download, list or delete files from Dropbox, an online file sharing, synchronization and backup service.'
  homepage 'https://github.com/andreafabrizi/Dropbox-Uploader'
  version '1.0'
  source_url 'https://github.com/andreafabrizi/Dropbox-Uploader/archive/1.0.tar.gz'
  source_sha256 '8c9be8bd38fb3b0f0b4d1a863132ad38c8299ac62ecfbd1e818addf32b48d84c'

  def self.install
    system "sed -i 's,dropbox_uploader.sh,dropbox_uploader,g' dropShell.sh"
    system "chmod +x dropShell.sh"
    system "chmod +x dropbox_uploader.sh"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp dropShell.sh #{CREW_DEST_DIR}/usr/local/bin/dropshell"
    system "cp dropbox_uploader.sh #{CREW_DEST_DIR}/usr/local/bin/dropbox_uploader"
    puts ""
    puts "Type 'dropbox_uploader' and follow the instructions to finish the installation.".lightblue
    puts "To execute The Interactive Dropbox SHELL, type 'dropshell'.".lightblue
    puts ""
  end
end
