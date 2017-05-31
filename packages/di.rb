require 'package'

class Di < Package
  description '\'di\' is a disk information utility, displaying everything (and more) that your \'df\' command does.'
  homepage 'http://gentoo.com/di/'
  version '4.43'
  source_url 'http://gentoo.com/di/di-4.43.tar.gz'
  source_sha1 'ddced0d59d29ccdcbc4282bc7464a925d14955e1'

  def self.build
    system "sed -i '40s,= ,= $(DESTDIR)/,' Makefile" # set correct bin path
    system "sed -i '44s,= ,= $(DESTDIR)/,' Makefile" # add destdir to man path
    system "sed -i '61s,share/,,' Makefile"          # remove share segment
    system "sed -i '52s/root/chronos/' Makefile"     # set correct owner
    system "sed -i '53s/bin/chronos/' Makefile"      # set correct group
    system "CC=gcc prefix=/usr/local make -e"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "-e", "install"
  end
end
