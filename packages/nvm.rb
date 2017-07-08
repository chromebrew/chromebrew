require 'package'

class Nvm < Package
  description 'Node Version Manager - Simple bash script to manage multiple active node.js versions.'
  homepage 'https://github.com/creationix/nvm'
  version '0.33.2'
  source_url 'https://github.com/creationix/nvm/archive/v0.33.2.tar.gz'
  source_sha256 '2ad455a0752d5bae49ecff38a8a7778cc734c2d0ece9942dfdd164c2f01e80da'

  def self.install
    system "NVM_DIR=/usr/local/share/nvm && bash install.sh"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/share/nvm"
    puts ""
    puts "To complete the installation, execute:".lightblue
    puts "source ~/.bashrc".lightblue
    puts ""
    puts "To uninstall, do NOT simply run `crew remove nvm`!".lightblue
    puts ""
    puts "Execute the following instead:".lightblue
    puts "rm -rf /usr/local/share/nvm".lightblue
    puts ""
    puts "You will also need to remove any lines with NVM_DIR in ~/.bashrc.".lightblue
    puts ""
  end
end
