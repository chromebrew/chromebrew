require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '7.0.15'
  source_url 'https://github.com/heroku/cli/archive/v7.0.15.tar.gz'
  source_sha256 'ca02341f8a80aaccef256f7c6a05ce8c0fdbbb78d7423aee64c1ec0c18362271'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.0.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.0.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.0.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.0.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '504e4ee8d5bc5c0bcd508fdea906ad79096de9c30af7b2e0cdf915c9fc445e2e',
     armv7l: '504e4ee8d5bc5c0bcd508fdea906ad79096de9c30af7b2e0cdf915c9fc445e2e',
       i686: 'deb047ee88badf1894bda5eace77b3aee1e2ba762f1a9d2484e39e907d47c64d',
     x86_64: 'f2c0bf6a765f1135679b6fcbbcd843046df62bd79c6d176013f7fee824345bb9',
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
