require 'package'

class Tree < Package
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
