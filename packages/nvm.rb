require 'package'

class Nvm < Package
  description 'Node Version Manager - Simple bash script to manage multiple active node.js versions.'
  homepage 'https://github.com/creationix/nvm'
  version '0.33.8'
  source_url 'https://github.com/creationix/nvm/archive/v0.33.8.tar.gz'
  source_sha256 '59429f4bf3da7c2b7bcac06c488054dd774ae6962bdcefe249015d3590704b0b'

  binary_url ({
  })
  binary_sha256 ({
  })

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
