require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '11.12.1'
  license 'Heroku-TOS'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  source_url({
    aarch64: 'https://cli-assets.heroku.com/channels/stable/heroku-linux-arm.tar.xz',
     armv7l: 'https://cli-assets.heroku.com/channels/stable/heroku-linux-arm.tar.xz',
     x86_64: 'https://cli-assets.heroku.com/channels/stable/heroku-linux-x64.tar.xz'
  })
  source_sha256({
    aarch64: 'be4d913db666e1cdb1631479457ef333a5d19871a8d56943195d78ea06c8416d',
     armv7l: 'be4d913db666e1cdb1631479457ef333a5d19871a8d56943195d78ea06c8416d',
     x86_64: '241ebfd6da0e540ecdbc50655099b3410db682554f4e506c9ea406c312a55e73'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/heroku"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/heroku"
    FileUtils.ln_s "#{CREW_PREFIX}/share/heroku/bin/heroku", "#{CREW_DEST_PREFIX}/bin/heroku"
  end
end
