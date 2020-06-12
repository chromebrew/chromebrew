require 'package'

class Nvm < Package
  description 'Node Version Manager - Simple bash script to manage multiple active node.js versions.'
  homepage 'https://github.com/creationix/nvm'
  version '0.33.8'
  compatibility 'all'
  source_url 'https://github.com/creationix/nvm/archive/v0.33.8.tar.gz'
  source_sha256 '59429f4bf3da7c2b7bcac06c488054dd774ae6962bdcefe249015d3590704b0b'

  def self.install
    system "sed -i 's,\$HOME/.nvm,#{CREW_DEST_PREFIX}/share/nvm,g' install.sh"
    system "NVM_DIR=#{CREW_DEST_PREFIX}/share/nvm && bash install.sh"
    system "rm -rf #{CREW_DEST_PREFIX}/share/nvm/.git*"
    system "rm -rf #{CREW_DEST_PREFIX}/share/nvm/test"
  end

  def self.postinstall
    puts
    puts "To complete the installation, execute:".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To uninstall, execute the following:".lightblue
    puts "crew remove nvm".lightblue
    puts "rm -rf #{CREW_PREFIX}/share/nvm".lightblue
    puts "Delete any lines with NVM_DIR in ~/.bashrc.".lightblue
    puts
  end
end
