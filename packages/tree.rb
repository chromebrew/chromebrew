require 'package'

class Tree < Package
  description 'Tree is a recursive directory listing command that produces a depth indented listing of files, which is colorized ala dircolors if the LS_COLORS environment variable is set and output is to tty.'
  homepage 'http://mama.indstate.edu/users/ice/tree/'
  version '1.8.0'
  source_url 'http://mama.indstate.edu/users/ice/tree/src/tree-1.8.0.tgz'
  source_sha256 '715d5d4b434321ce74706d0dd067505bb60c5ea83b5f0b3655dae40aa6f9b7c2'

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i '25s,=,=$(DESTDIR),' Makefile"
    system "sed -i '27s,=,=$(DESTDIR),' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
