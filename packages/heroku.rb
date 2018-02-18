require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '6.15.22'
  source_url 'https://github.com/heroku/cli/archive/v6.15.22.tar.gz'
  source_sha256 '51f2f82bff5c4dd10a02c6cc177139a91a4b0caa5c85597aafc371caa0da763a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.15.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.15.22-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.15.22-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.15.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '72fea4ba83d5d8d84dcf4ef4046c30d633ee18fe750ff9e0fde8763aa735157a',
     armv7l: '72fea4ba83d5d8d84dcf4ef4046c30d633ee18fe750ff9e0fde8763aa735157a',
       i686: 'f5b6490e7a6919a5f42d32f0361797021bd4e1e4b8d0bc2f017a222c71e35ff9',
     x86_64: '10e993f7f72df5c41b19ef8af2c65ec81f5bbd107483d014b05c73b53e66aada',
  })
  
  depends_on 'yarn'

  def self.build
    system 'yarn install'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/share/heroku"
    system "cp -r . #{CREW_DEST_PREFIX}/share/heroku"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "ln -s #{CREW_PREFIX}/share/heroku/bin/run #{CREW_DEST_PREFIX}/bin/heroku"
  end
end
