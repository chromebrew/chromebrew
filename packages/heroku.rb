require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '11.14.0'
  license 'Heroku-TOS'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  source_url({
    aarch64: 'https://cli-assets.heroku.com/channels/stable/heroku-linux-arm.tar.xz',
     armv7l: 'https://cli-assets.heroku.com/channels/stable/heroku-linux-arm.tar.xz',
     x86_64: 'https://cli-assets.heroku.com/channels/stable/heroku-linux-x64.tar.xz'
  })
  source_sha256({
    aarch64: 'f35a3255e7aac6a3ea699bf9c19fd615b5edb7047312a0f2130281ad33711019',
     armv7l: 'f35a3255e7aac6a3ea699bf9c19fd615b5edb7047312a0f2130281ad33711019',
     x86_64: '338233767ca93307dbe23f3fdc08fd0fb918031bae15af845c0eb42d14e8eb3a'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/heroku"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/heroku"
    FileUtils.ln_s "#{CREW_PREFIX}/share/heroku/bin/heroku", "#{CREW_DEST_PREFIX}/bin/heroku"
  end
end
