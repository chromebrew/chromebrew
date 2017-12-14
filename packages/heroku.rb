require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '6.14.42'
  source_url 'https://github.com/heroku/cli/archive/v6.14.42.tar.gz'
  source_sha256 'cf129c61622be965384a66355a702c7919d6bc2e45b60969c6e9f9fa7342988e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.14.42-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.14.42-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.14.42-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.14.42-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '62360b8ae87e46c8cfb02cdfaf2ee9312781b9578cb006aecd10ab07a2ce58e4',
     armv7l: '62360b8ae87e46c8cfb02cdfaf2ee9312781b9578cb006aecd10ab07a2ce58e4',
       i686: '83f2f2c4a28916e9d737c85fa0d54032d56a5384bb7a36806ffba4112bada655',
     x86_64: '0b5613c26ad45d13610a978c0695ec68be4682ab7c83c8339a0908a795dfb94e',
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
