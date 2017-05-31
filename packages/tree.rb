require 'package'

class Tree < Package
  description 'Tree is a recursive directory listing command that produces a depth indented listing of files, which is colorized ala dircolors if the LS_COLORS environment variable is set and output is to tty.'
  homepage 'http://mama.indstate.edu/users/ice/tree/'
  version '1.7.0'
  source_url 'http://mama.indstate.edu/users/ice/tree/src/tree-1.7.0.tgz'
  source_sha1 '35bd212606e6c5d60f4d5062f4a59bb7b7b25949'

  def self.build
    system "sed -i 's,/usr,/usr/local,g' Makefile"
    system "sed -i '25s,=,=$(DESTDIR),' Makefile"
    system "sed -i '27s,=,=$(DESTDIR),' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
