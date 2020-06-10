require 'package'

class Less < Package
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '530'
  compatibility 'all'
  source_url 'http://www.greenwoodsoftware.com/less/less-530.tar.gz'
  source_sha256 '503f91ab0af4846f34f0444ab71c4b286123f0044a4964f1ae781486c617f2e2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/less-530-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/less-530-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/less-530-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/less-530-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9f5b24b30b0eda422aa07c5cf34614403a561ecf80049ef16b85d4b6aafaf131',
     armv7l: '9f5b24b30b0eda422aa07c5cf34614403a561ecf80049ef16b85d4b6aafaf131',
       i686: '8807c4e382fe778a6518f3dfe11bf4eba3747dfb749383312263ebf42c9aedbd',
     x86_64: '163b184835f8094de3e87319f21d0b6d246a5add03f7cc7e9252e2de7555b321',
  })

  depends_on 'compressdoc' => :build
  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --with-regex=posix"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
  end

  def self.check
    system "make", "check"
  end
end
