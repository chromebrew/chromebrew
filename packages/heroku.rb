require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '6.13.6'
  source_url 'https://github.com/heroku/cli/archive/v6.13.6.tar.gz'
  source_sha256 '395c7e22d16b1fce2d5ed4ac1e022dbd3c9aa8fdbc172d9dadf86ba9c1ad6978'

  depends_on 'nodebrew' unless `node --version`
  depends_on 'yarn'

  def self.build
    system 'nodebrew install-binary latest && nodebrew use latest' unless `node --version`
    system 'yarn install'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/heroku"
    system "cp -r . #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/heroku"
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    system "ln -s #{CREW_LIB_PREFIX}/heroku/bin/run #{CREW_DEST_DIR}#{CREW_PREFIX}/bin/heroku"
  end
end
