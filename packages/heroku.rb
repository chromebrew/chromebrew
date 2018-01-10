require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '6.15.13'
  source_url 'https://github.com/heroku/cli/archive/v6.15.13.tar.gz'
  source_sha256 '16c58123cbdbb67b6f2179e2700e8573f71c62c0f974a01e33fe7c5510176bb3'
 
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
