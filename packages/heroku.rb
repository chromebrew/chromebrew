require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '7.5.7'
  source_url 'https://github.com/heroku/cli/archive/v7.5.7.tar.gz'
  source_sha256 '7ec61e4f27b2c16245b8613aeb62a8f9c0470db6a75251aef483df516368ee39'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.5.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.5.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.5.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.5.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd628432f3d53e16c8b052692ea5f3cc0a9cd07c4582a781aa96a2e920d62afdf',
     armv7l: 'd628432f3d53e16c8b052692ea5f3cc0a9cd07c4582a781aa96a2e920d62afdf',
       i686: '2b2f9da6e1cac89b37bb4f5c308e60a65a32ee5234d92374148e01ed0abe6af8',
     x86_64: '1c574eeaf16c78f3b0d2d379690de55a65f7f1cdb5789210f5124b769bc21fdf',
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
