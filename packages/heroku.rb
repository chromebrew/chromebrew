require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '7.33.3'
  compatibility 'all'
  source_url 'https://github.com/heroku/cli/archive/v7.33.3.tar.gz'
  source_sha256 'ce0efe5df44b59467586c0b4a7b4421ca11bb254829eecc35788bc204e90a627'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.33.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.33.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.33.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.33.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b6a950d1dcef6f68298d527c4b36886d65a2c366d75a02b244c51a86b7045fed',
     armv7l: 'b6a950d1dcef6f68298d527c4b36886d65a2c366d75a02b244c51a86b7045fed',
       i686: 'eec95cb00683cb86beba01aef9cb22a2b1f6ad5a75850769200085c6eaa293c4',
     x86_64: '8f2dade4d230dfafdfd300393af837f07982a10456b1bf17db3ee32be21c3e66',
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
