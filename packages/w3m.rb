require 'package'

class W3m < Package
  description 'w3m is a text-based browser, pager and HTML typesetter'
  homepage 'http://w3m.sourceforge.net/'
  version '0.5.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/w3m/-/archive/debian/0.5.3-38/w3m-debian-0.5.3-38.tar.bz2'
  source_sha256 '183d4a1821654fa2779d2dfd4bad1eef21237114c76b6dfbe806057ec086546b'

  depends_on 'openssl'
  depends_on 'gdk_pixbuf'
  depends_on 'imlib2'
  depends_on 'mailutils'

  def self.patch
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\"\${i}\"; done"
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --with-imagelib='gdk-pixbuf imlib2' \
            --with-editor=$(which vi) \
            --with-mailer=$(which mail) \
            --without-browser \
            --with-ssl \
            --with-termlib='ncurses termcap'"
    system "make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
