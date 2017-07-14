require 'package'

class Tree < Package
  description 'Tree is a recursive directory listing command that produces a depth indented listing of files, which is colorized ala dircolors if the LS_COLORS environment variable is set and output is to tty.'
  homepage 'http://mama.indstate.edu/users/ice/tree/'
  version '1.7.0'
  source_url 'http://mama.indstate.edu/users/ice/tree/src/tree-1.7.0.tgz'
  source_sha256 '6957c20e82561ac4231638996e74f4cfa4e6faabc5a2f511f0b4e3940e8f7b12'

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
