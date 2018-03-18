require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '6.15.31'
  source_url 'https://github.com/heroku/cli/archive/v6.15.31.tar.gz'
  source_sha256 '940c8083b90f95c5400df37dd0de19e423bd665e729c3d8e03b4c1ed34852d95'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.15.31-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.15.31-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.15.31-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.15.31-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '14bedf57aba0005bc6c8446dc387b127a18de0fc54e2c22184e1127380447937',
     armv7l: '14bedf57aba0005bc6c8446dc387b127a18de0fc54e2c22184e1127380447937',
       i686: '68024018ccd7fa5053d07a32694a3040c7f94cd0422d27545992391f71a7e71c',
     x86_64: '1cbc40d073dfb2ef09b36ce258ed581e155f2d29634ed8080c316b6b3177eb62',
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
