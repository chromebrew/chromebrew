require 'package'

class Nvm < Package
  description 'Node Version Manager - Simple bash script to manage multiple active node.js versions.'
  homepage 'https://github.com/creationix/nvm'
  version '0.33.2'
  source_url 'https://github.com/creationix/nvm/archive/v0.33.2.tar.gz'
  source_sha256 '2ad455a0752d5bae49ecff38a8a7778cc734c2d0ece9942dfdd164c2f01e80da'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nvm-0.33.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nvm-0.33.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nvm-0.33.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nvm-0.33.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f0d15c5ff6bac0d2cea927db6ed3cb778f73f1e25f5e8d3975f6ea73c7fc52f1',
     armv7l: 'f0d15c5ff6bac0d2cea927db6ed3cb778f73f1e25f5e8d3975f6ea73c7fc52f1',
       i686: 'a6a161692e32907872fc5864b0d2dee0509b7980d30594796aa72be897b66352',
     x86_64: '67e327de8bcfb1ec8266827d2d7f1fd48486b7af4f9a0179caad9caf4e05d3c1',
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
