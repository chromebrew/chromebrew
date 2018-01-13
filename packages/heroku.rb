require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '6.15.13'
  source_url 'https://github.com/heroku/cli/archive/v6.15.13.tar.gz'
  source_sha256 '16c58123cbdbb67b6f2179e2700e8573f71c62c0f974a01e33fe7c5510176bb3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.15.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.15.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.15.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-6.15.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2daefeed09921df4f334673ad6717c5b8f1fa98e8da295708ea4672c5f94d824',
     armv7l: '2daefeed09921df4f334673ad6717c5b8f1fa98e8da295708ea4672c5f94d824',
       i686: 'a149144d0ac62cc830a1e0bc43bee10b1bee551dd14be91783daf37a6ad00ca7',
     x86_64: '7fc6cec1f3d3dee50860edcfa7946647e96a2756858b58f2c9f367ea0dbc20bd',
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
