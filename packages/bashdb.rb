require 'package'

class Bashdb < Package
  description 'The Bash Debugger Project is a source-code debugger for bash that follows the gdb command syntax.'
  homepage 'http://bashdb.sourceforge.net/'
  version '4.3-0.91'
  source_url 'https://downloads.sourceforge.net/project/bashdb/bashdb/4.3-0.91/bashdb-4.3-0.91.tar.bz2'
  source_sha256 '60117745813f29070a034c590c9d70153cc47f47024ae54bfecdc8cd86d9e3ea'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'compressdoc' => :build

  def self.build
    system "./configure \
            --bindir=#{CREW_PREFIX}/bin \
            --datadir=#{CREW_PREFIX}/share \
            --infodir=#{CREW_PREFIX}/info \
            --mandir=#{CREW_PREFIX}/man"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/man/man1"
  end
end
