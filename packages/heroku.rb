require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '7.16.0'
  source_url 'https://github.com/heroku/cli/archive/v7.16.0.tar.gz'
  source_sha256 '7afe83110494a958bccd2be5ea83b6f86f9abd2b7bf7e4530137f706a4e08ff5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.16.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.16.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.16.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.16.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e81447458cee23759364b05ed301cc89d89ea6db14ef9198272a1b010340570e',
     armv7l: 'e81447458cee23759364b05ed301cc89d89ea6db14ef9198272a1b010340570e',
       i686: 'c3a8485f2f6427ca86e4ca4bf81d74a8e401e8c05627ebbd77d1bc04fa2c9554',
     x86_64: 'da7204aacb05c99e034a4f2a9c95e9e44b2493bf9c0717126ab00af6948edb5b',
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
