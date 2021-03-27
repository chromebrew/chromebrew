require 'package'

class Nvm < Package
  description 'Node Version Manager - Simple bash script to manage multiple active node.js versions.'
  homepage 'https://github.com/nvm-sh/nvm'
  version '0.35.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nvm-sh/nvm/archive/v0.35.3.tar.gz'
  source_sha256 'a88c8c1e920ca24c09a2f9f0733afa9d6ccf03fe068e9ffba488416d9710d4fb'

  def self.install
    system "sed -i 's,\$HOME/.nvm,#{CREW_DEST_PREFIX}/share/nvm,g' install.sh"
    system "NVM_DIR=#{CREW_DEST_PREFIX}/share/nvm && bash install.sh"
    system "rm -rf #{CREW_DEST_PREFIX}/share/nvm/.git*"
    system "rm -rf #{CREW_DEST_PREFIX}/share/nvm/test"
  end

  def self.remove
    puts
    puts "Don't forget to run:"
    puts "rm -rf #{CREW_PREFIX}/share/nvm".lightblue
    puts
  end
end
