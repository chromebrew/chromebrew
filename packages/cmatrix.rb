require 'package'

class Cmatrix < Package
  description "CMatrix is a program to see the cool scrolling lines from 'The Matrix' movie."
  homepage 'http://www.asty.org/cmatrix/'
  version '1.2'
  source_url 'https://github.com/abishekvashok/cmatrix/archive/1.2.tar.gz'
  source_sha256 '6b0b9aff4585147843c4cf8a8c9c6048500f66dc4887a38922197dfa326b57c8'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'buildessential'
  depends_on 'ncurses'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses ./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
