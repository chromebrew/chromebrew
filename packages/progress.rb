require 'package'

class Progress < Package
  description 'Linux tool to show progress for cp, mv, dd, ... (formerly known as cv)'
  homepage 'https://github.com/Xfennec/progress'
  version '0.13.1-1'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/Xfennec/progress/archive/v0.13.1.tar.gz'
  source_sha256 '064c95e8b93893dbf4b4b8152290cbb3b0c005eda0cae500353561048c9939a5'

  depends_on 'pkgconfig' => :build
  depends_on 'ncursesw'

  def self.patch
    system "sed -i '9,14d' Makefile"
    system "sed -i 's,PREFIX ?= /usr/local,PREFIX ?= #{CREW_PREFIX},' Makefile"
  end
  
  def self.build
    system "make CFLAGS=' -I#{CREW_PREFIX}/include/ncursesw'"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
