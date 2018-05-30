require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '7.0.62'
  source_url 'https://github.com/heroku/cli/archive/v7.0.62.tar.gz'
  source_sha256 '6cb037fea16f9076c351825f18c46eb87af500073db4a0bcedc543645910e425'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.0.62-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.0.62-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.0.62-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.0.62-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c62ec8fc487169a62ac8d883bf1b7f4f9714adcd9b7867e562e7dfa541df7159',
     armv7l: 'c62ec8fc487169a62ac8d883bf1b7f4f9714adcd9b7867e562e7dfa541df7159',
       i686: '414a6774198b8af153f9a8d616877101af788d91965fa4f576917d9c7d18e80a',
     x86_64: 'cae71bc253e39f56644d3f636d1443131efeae2a74f87289ca8c71deca7d4b6e',
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
