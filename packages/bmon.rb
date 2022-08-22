require 'package'

class Bmon < Package
  description 'bmon is a commandline bandwidth monitor and rate estimator.'
  homepage 'https://www.infradead.org/~tgr/bmon/'
  version '4.0-1'
  license 'BSD-2 and MIT'
  compatibility 'all'
  source_url 'https://github.com/tgraf/bmon/releases/download/v4.0/bmon-4.0.tar.gz'
  source_sha256 '02fdc312b8ceeb5786b28bf905f54328f414040ff42f45c83007f24b76cc9f7a'

  depends_on 'libnl3'

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_OPTIONS} \
            --without-ncurses \
            --with-ncursesw"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
