require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '6.13.5'
  source_url 'https://github.com/heroku/cli/archive/v6.13.5.tar.gz'
  source_sha256 '769943a2e272f9b9332d85cfd5d4f49a7a3070a06b81e6da1cb33b4723a85607'

  def self.install
    case ARCH
    when 'i686'
      system 'wget https://cli-assets.heroku.com/heroku-cli/channels/stable/heroku-cli-linux-x86.tar.gz -O heroku-cli.tar.gz'
    when 'x86_64'
      system 'wget https://cli-assets.heroku.com/heroku-cli/channels/stable/heroku-cli-linux-x64.tar.gz -O heroku-cli.tar.gz'
    else
      abort 'Architecture not supported.'.lightred
    end
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/lib"
    system "tar xvf heroku-cli.tar.gz"
    system "mv heroku-cli-v* heroku-cli-linux-#{ARCH}"
    system "mv heroku-cli-linux-#{ARCH} #{CREW_DEST_DIR}/usr/local/lib"
    FileUtils.cd("#{CREW_DEST_DIR}/usr/local/bin") do
      system "ln -s /usr/local/lib/heroku-cli-linux-#{ARCH}/bin/heroku heroku"
    end
  end
end
