require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '6.16.13'
  source_url 'https://github.com/heroku/cli/archive/v6.16.13.tar.gz'
  source_sha256 '70be5c06f541f30d768bd3bb486db73a8e5873f136fd3e23b69717f9cca6246a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.16.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.16.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.16.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.16.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a38a8ab189e8ae52b268a114fbdb25b759b436085327312436c4e023b0e55b47',
     armv7l: 'a38a8ab189e8ae52b268a114fbdb25b759b436085327312436c4e023b0e55b47',
       i686: '2c8c80ea39a22abfd81cfe4ad751ee9578dd2818a01050dfe5b09acf9b18028a',
     x86_64: '23b38b78a9ff83a0a2b77a908f3616e1ccedbaa44c0a474f21dd40f2d1eabeaa',
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
