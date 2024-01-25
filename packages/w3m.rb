require 'package'

class W3m < Package
  description 'w3m is a text-based browser, pager and HTML typesetter'
  homepage 'http://w3m.sourceforge.net/'
  version '0.5.3-20220429'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tats/w3m/archive/v0.5.3+git20220429.tar.gz'
  source_sha256 '6d76fcccb7c94658f2753f0777f69283d5cb447004a0d0d3087c1d873edc0af3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a0af0f7d06a26072f5af6a5dd16431b226caaa7aeec7b3af89b7f0a602ff987a',
     armv7l: 'a0af0f7d06a26072f5af6a5dd16431b226caaa7aeec7b3af89b7f0a602ff987a',
       i686: '0c974bf73bac0731ddffa04259fb0d87caf8a8d0cef364d3fe070a6a6be46122',
     x86_64: 'c54c80e2253c9026ee038bc46dc3e36ea59d1899a8b4f4d3c7ec93349fd90cc1'
  })

  depends_on 'bdwgc'
  depends_on 'gdk_pixbuf'
  depends_on 'imlib2'
  depends_on 'mailutils'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --with-imagelib='gdk-pixbuf-2.0 imlib2' \
            --with-editor=$(which vi) \
            --with-mailer=$(which mail) \
            --with-ssl=#{CREW_PREFIX}/include/openssl \
            --with-termlib='terminfo mytinfo termcap tinfo ncurses curses'"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
