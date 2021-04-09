require 'package'

class Nvm < Package
  description 'Node Version Manager - Simple bash script to manage multiple active node.js versions.'
  homepage 'https://github.com/nvm-sh/nvm'
  version '0.35.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nvm-sh/nvm/archive/v0.35.3.tar.gz'
  source_sha256 'a88c8c1e920ca24c09a2f9f0733afa9d6ccf03fe068e9ffba488416d9710d4fb'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nvm-0.35.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nvm-0.35.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nvm-0.35.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nvm-0.35.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'eba4a5fdb550729b0d406cf5dd5791f0c4bc166d8cfc195abadc60a8323b6445',
     armv7l: 'eba4a5fdb550729b0d406cf5dd5791f0c4bc166d8cfc195abadc60a8323b6445',
       i686: '89f5bed7552b0f80689c3dd2dd46c1357b4b77a96502216d794098e6a3d607c7',
     x86_64: '864317f63b74224ed74bc131c5596e11524abb277e717494111c98d75fd86de2'
  })

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
