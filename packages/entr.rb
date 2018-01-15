require 'package'

class Entr < Package
  description 'Run arbitrary commands when files change'
  homepage 'http://entrproject.org/'
  version '3.9'
  source_url 'http://entrproject.org/code/entr-3.9.tar.gz'
  source_sha256 '02d78f18ae530e64bfbb9d8e0250962f85946e10850dd065899d03af15f26876'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/entr-3.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/entr-3.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/entr-3.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/entr-3.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bb30f02b3bbb9f212cd2890ec398f2e619a29dc0bbc0192a36e9657f2cfcc819',
     armv7l: 'bb30f02b3bbb9f212cd2890ec398f2e619a29dc0bbc0192a36e9657f2cfcc819',
       i686: 'd9b85cfd5995132b88f3c73e3514ad07d6a31102ffdb49c629a682ac64551d51',
     x86_64: 'a2c80447e6772923445e62b75b5498622588ffc3f7f4d045f9b20e52770eb989',
  })

  def self.build
    system 'cp Makefile.linux Makefile'
    system "PREFIX=#{CREW_PREFIX} make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
