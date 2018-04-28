require 'package'

class Multitail < Package
  description 'MultiTail allows you to monitor logfiles and command output in multiple windows in a terminal, colorize, filter and merge.'
  homepage 'https://www.vanheusden.com/multitail/'
  version '6.4.3'
  source_url 'https://github.com/flok99/multitail/archive/v6.3.tar.gz'
  source_sha256 'bbc478e562b66e87f1b7191864702314de33ecf6ce08155b6a955bd25242a4f8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/multitail-6.4.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/multitail-6.4.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/multitail-6.4.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/multitail-6.4.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd77ae3e6dd7e70ae0e96e8fa8df966379d239a27095329af54dc43c813f675c2',
     armv7l: 'd77ae3e6dd7e70ae0e96e8fa8df966379d239a27095329af54dc43c813f675c2',
       i686: '5d91c88fc441f62ba9a6ba8fcc61a2c94c927fe1b4b0d12a8cb9d9665ec108ee',
     x86_64: '8a9f738f63365e9902482077ff6ae70272e57313595b75a75414feb2339f8c00',
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
