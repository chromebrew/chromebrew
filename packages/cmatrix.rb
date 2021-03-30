require 'package'

class Cmatrix < Package
  description "CMatrix is a program to see the cool scrolling lines from 'The Matrix' movie."
  homepage 'http://www.asty.org/cmatrix/'
  version '1.2-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/abishekvashok/cmatrix/archive/1.2.tar.gz'
  source_sha256 '6b0b9aff4585147843c4cf8a8c9c6048500f66dc4887a38922197dfa326b57c8'

  depends_on 'ncursesw'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw \
            ./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
