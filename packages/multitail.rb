require 'package'

class Multitail < Package
  description 'MultiTail allows you to monitor logfiles and command output in multiple windows in a terminal, colorize, filter and merge.'
  homepage 'https://www.vanheusden.com/multitail/'
  version '6.4.2'
  source_url 'https://www.vanheusden.com/multitail/multitail-6.4.2.tgz'
  source_sha256 'af1d5458a78ad3b747c5eeb135b19bdca281ce414cefdc6ea0cff6d913caa1fd'

  depends_on 'ncursesw'

  def self.build
    system 'make'
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
