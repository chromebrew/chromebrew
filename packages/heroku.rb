require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '7.0.35'
  source_url 'https://github.com/heroku/cli/archive/v7.0.35.tar.gz'
  source_sha256 '62216b82c2d32cc2e524e26642722904d24df74af4194bcf94e186d7c3038033'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.0.35-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.0.35-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.0.35-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.0.35-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bf4cef5f266fcafd2fd00f5d616f2835407508380630ee9ca2d7c7de7cc408bd',
     armv7l: 'bf4cef5f266fcafd2fd00f5d616f2835407508380630ee9ca2d7c7de7cc408bd',
       i686: '3a62da231a09acb567a8e52123f7bd49e8a33d15d7ce2cab6be75d4de64b8751',
     x86_64: '42e37b3c493e4e3667d2d7b188c0588a5edc81806b9401507cd642f1580c02e9',
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
