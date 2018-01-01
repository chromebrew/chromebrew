require 'package'

class Pagemon < Package
  description 'Pagemon is an interactive memory/page monitoring tool allowing one to browse the memory map of an active running process.'
  homepage 'http://kernel.ubuntu.com/~cking/pagemon/'
  version '0.01.11'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/pagemon/pagemon-0.01.11.tar.gz'
  source_sha256 'c1371f362fe6f2a7e8424a74618eb5e9cb39151e41ee6fb1a466cc0e66ab8e94'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'

  def self.build
    system "sed -i 's,/usr,/usr/local,g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s/$/ -I\\/usr\\/local\\/include\\/ncurses/' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
