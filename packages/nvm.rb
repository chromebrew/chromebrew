require 'package'

class Nvm < Package
  description 'Node Version Manager - Simple bash script to manage multiple active node.js versions.'
  homepage 'https://github.com/creationix/nvm'
  version '0.33.2'
  source_url 'https://github.com/creationix/nvm/archive/v0.33.2.tar.gz'
  source_sha256 '2ad455a0752d5bae49ecff38a8a7778cc734c2d0ece9942dfdd164c2f01e80da'

  def self.install
    system "sed -i 's,\$HOME/.nvm,/usr/local/share/nvm,g' install.sh"
    system "NVM_DIR=/usr/local/share/nvm && bash install.sh"
    system "rm -rf /usr/local/share/nvm/.git*"
    system "rm -rf /usr/local/share/nvm/test"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/share"
    system "cp -r /usr/local/share/nvm #{CREW_DEST_DIR}/usr/local/share"
    puts ""
    puts "To complete the installation, execute:".lightblue
    puts "source ~/.bashrc".lightblue
    puts ""
    puts "To uninstall, in addition to 'crew remove nvm' you will".lightblue
    puts "also need to delete any lines with NVM_DIR in ~/.bashrc.".lightblue
    puts ""
  end
end
