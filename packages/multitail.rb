require 'package'

class Multitail < Package
  description 'MultiTail allows you to monitor logfiles and command output in multiple windows in a terminal, colorize, filter and merge.'
  homepage 'https://www.vanheusden.com/multitail/'
  version '6.4.2-2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.vanheusden.com/multitail/multitail-6.4.2.tgz'
  source_sha256 'af1d5458a78ad3b747c5eeb135b19bdca281ce414cefdc6ea0cff6d913caa1fd'

  depends_on 'ncursesw'

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
