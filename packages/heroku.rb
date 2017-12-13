require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '6.14.42'
  source_url 'https://github.com/heroku/cli/archive/v6.14.42.tar.gz'
  source_sha256 'cf129c61622be965384a66355a702c7919d6bc2e45b60969c6e9f9fa7342988e'
 
  
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
