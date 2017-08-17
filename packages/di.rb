require 'package'

class Di < Package
  description '\'di\' is a disk information utility, displaying everything (and more) that your \'df\' command does.'
  homepage 'http://gentoo.com/di/'
  version '4.44'
  source_url 'https://gentoo.com/di/di-4.44.tar.gz'
  source_sha256 '963d00cadbf5a115ff31b31b0d6141be751c7b0a209e50990cb78e36d1a50320'

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
