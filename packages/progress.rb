require 'package'

class Progress < Package
  description 'Linux tool to show progress for cp, mv, dd, ... (formerly known as cv)'
  homepage 'https://github.com/Xfennec/progress'
  version '0.13.1'
  compatibility 'all'
  source_url 'https://github.com/Xfennec/progress/archive/v0.13.1.tar.gz'
  source_sha256 '064c95e8b93893dbf4b4b8152290cbb3b0c005eda0cae500353561048c9939a5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/progress-0.13.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/progress-0.13.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/progress-0.13.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/progress-0.13.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '47368db75bdb46fd8ee91cb1838fd593d29b7df8abf875b67ecd79df1251817a',
     armv7l: '47368db75bdb46fd8ee91cb1838fd593d29b7df8abf875b67ecd79df1251817a',
       i686: 'fd29c80773bf45ffc6ed085f8a0950920138226519c199792ec9dffc0f59c43a',
     x86_64: 'e3e4b39e3be040d3d1ce716b253a625d0aa77839cdc7e22d479649748bbfa403',
  })

  depends_on 'pkgconfig' => :build
  depends_on 'ncurses'

  def self.build
    system "sed -i '9,14d' Makefile"
    system "sed -i 's,PREFIX ?= /usr/local,PREFIX ?= #{CREW_PREFIX},' Makefile"
    system "make CFLAGS=' -I#{CREW_PREFIX}/include/ncurses'"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
