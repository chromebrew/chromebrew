require 'package'

class Hub < Package
  description 'hub is a command-line wrapper for git that makes you better at GitHub.'
  homepage 'https://hub.github.com/'
  version '2.3.0-pre10'
  source_url 'https://github.com/github/hub/archive/v2.3.0-pre10.tar.gz'
  source_sha256 '9b4764dc2647bc0c14de2bd386e6f428f002d93baf01059d994e1cfa928483fc'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/hub-2.3.0-pre10-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/hub-2.3.0-pre10-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/hub-2.3.0-pre10-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/hub-2.3.0-pre10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8b25ece4744967afd431ca2016d63f34ac63ffba866d0d208bb106ac080bd13b',
     armv7l: '8b25ece4744967afd431ca2016d63f34ac63ffba866d0d208bb106ac080bd13b',
       i686: '81aa10955f432703bd4bd2ecc01d038c013412508ca609e88d8ce59ebc50a751',
     x86_64: '7a6926ac2c5ccdd73fb043873b891838c645febd80ef06dee58b9d636bede0fb',
  })

  depends_on 'git'
  depends_on 'go'

  def self.install
    system "script/build -o /usr/local/bin/hub"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp /usr/local/bin/hub #{CREW_DEST_DIR}/usr/local/bin"
    puts ""
    puts "You will need to add an alias in order to use hub as a git wrapper:".lightblue
    puts "echo \"alias git=hub\" >> ~/.bashrc && source ~/.bashrc".lightblue
    puts ""
  end
end
