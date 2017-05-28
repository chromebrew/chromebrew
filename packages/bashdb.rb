require 'package'

class Bashdb < Package
  version '4.4-0.92'
  source_url 'https://downloads.sourceforge.net/project/bashdb/bashdb/4.2-0.92/bashdb-4.4-0.92.tar.gz'
  source_sha1 '918c7d576c476c4b7d768e1fccda6150cf5ca62d'

  def self.build
    system "./configure \
            --bindir=/usr/local/bin \
            --datadir=/usr/local \
            --infodir=/usr/local \
            --mandir=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
