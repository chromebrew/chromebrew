require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '11.13.0'
  license 'Heroku-TOS'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  source_url({
    aarch64: 'https://cli-assets.heroku.com/channels/stable/heroku-linux-arm.tar.xz',
     armv7l: 'https://cli-assets.heroku.com/channels/stable/heroku-linux-arm.tar.xz',
     x86_64: 'https://cli-assets.heroku.com/channels/stable/heroku-linux-x64.tar.xz'
  })
  source_sha256({
    aarch64: '368dcfb6317506c97ae360f26db9b4cb4eb158f5f708a15e2bbb7b2a49d5f92a',
     armv7l: '368dcfb6317506c97ae360f26db9b4cb4eb158f5f708a15e2bbb7b2a49d5f92a',
     x86_64: '08b23086e3d71fca607878014033e54d964d6f160efdec5c9d66959b1af5bfd5'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/heroku"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/heroku"
    FileUtils.ln_s "#{CREW_PREFIX}/share/heroku/bin/heroku", "#{CREW_DEST_PREFIX}/bin/heroku"
  end
end
