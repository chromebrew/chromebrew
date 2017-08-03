require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '6.13.5'
  source_url 'https://github.com/heroku/cli/archive/v6.13.5.tar.gz'
  source_sha256 '769943a2e272f9b9332d85cfd5d4f49a7a3070a06b81e6da1cb33b4723a85607'

  depends_on 'nvm'
  depends_on 'yarn'

  def self.build
    system '. ~/.bashrc && nvm install stable'
    system 'yarn install'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/share/heroku"
    system "cp -r . #{CREW_DEST_DIR}/usr/local/share/heroku"
    FileUtils.cd("#{CREW_DEST_DIR}/usr/local/bin") do
      system "ln -s /usr/local/share/heroku/bin/run heroku"
    end
  end
end
