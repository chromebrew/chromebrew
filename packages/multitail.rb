require 'package'

class Multitail < Package
  description 'MultiTail allows you to monitor logfiles and command output in multiple windows in a terminal, colorize, filter and merge.'
  homepage 'https://www.vanheusden.com/multitail/'
  version '6.4.2-1'
  compatibility 'all'
  source_url 'https://www.vanheusden.com/multitail/multitail-6.4.2.tgz'
  source_sha256 'af1d5458a78ad3b747c5eeb135b19bdca281ce414cefdc6ea0cff6d913caa1fd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/multitail-6.4.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/multitail-6.4.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/multitail-6.4.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/multitail-6.4.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e82af7ce211b54d03d0938a27af1c9471c857440e81a88cd4b5188dd63913a27',
     armv7l: 'e82af7ce211b54d03d0938a27af1c9471c857440e81a88cd4b5188dd63913a27',
       i686: '553c789667253e18f656dfec111eaa05c9b95e69ee06ebcfec0488655ac00434',
     x86_64: '2059e4345609cbd3c45b40b5f741dc294e26f58f44e52b424f85c07ff3375ec7',
  })

  depends_on 'ncurses'

  def self.build
    system "sed -i 's,$(DESTDIR)/etc,$(DESTDIR)$(PREFIX)/etc,g' Makefile"
    system 'make'
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_DEST_DIR}$HOME"
    system "cp #{CREW_DEST_PREFIX}/etc/multitail.conf.new #{CREW_DEST_DIR}$HOME/.multitail.conf"
    system "cp #{CREW_DEST_PREFIX}/etc/multitail.conf.new $HOME/.multitail.conf"
  end

  def self.postinstall
    puts
    puts "To configure, edit $HOME/.multitail.conf".lightblue
    puts
  end
end
