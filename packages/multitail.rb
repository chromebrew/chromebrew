require 'package'

class Multitail < Package
  description 'MultiTail allows you to monitor logfiles and command output in multiple windows in a terminal, colorize, filter and merge.'
  homepage 'https://www.vanheusden.com/multitail/'
  version '7.1.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/folkertvanheusden/multitail.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b1283d41d4db63ae5f8128f518efdcf220eec40bf1e45156c1bf6919c83436e',
     armv7l: '9b1283d41d4db63ae5f8128f518efdcf220eec40bf1e45156c1bf6919c83436e',
       i686: '830acfcc1baecbaac8a8a3b2518b8713d8aa174357fd1222a5d6999b5ffad168',
     x86_64: '8e5532a2c47fa8f690433568cb3e9d8b9d4548ff643955d85c5da69b2d1a8696'
  })

  depends_on 'ncurses'

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}", "SYSCONFDIR=#{CREW_PREFIX}/etc"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "SYSCONFDIR=#{CREW_PREFIX}/etc", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
