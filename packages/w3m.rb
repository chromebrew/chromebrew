require 'package'

class W3m < Package
  description 'w3m is a text-based browser, pager and HTML typesetter'
  homepage 'http://w3m.sourceforge.net/'
  version '0.5.3-20210102'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tats/w3m/archive/v0.5.3+git20210102+deb11u0.5.tar.gz'
  source_sha256 'd428741e8657805a401667674c144a50084d47d20ef4bf00d92f695a93a7d33a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/w3m/0.5.3-20210102_armv7l/w3m-0.5.3-20210102-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/w3m/0.5.3-20210102_armv7l/w3m-0.5.3-20210102-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/w3m/0.5.3-20210102_i686/w3m-0.5.3-20210102-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/w3m/0.5.3-20210102_x86_64/w3m-0.5.3-20210102-chromeos-x86_64.tpxz',
  })
  binary_sha256({
    aarch64: 'bf03da42e618055be022f5f0939e6a7326524a5abb9ead031c5acdbb4ad7ce41',
     armv7l: 'bf03da42e618055be022f5f0939e6a7326524a5abb9ead031c5acdbb4ad7ce41',
       i686: '5586b147ec8037ccfc2d3b8fc433bd2b8b9d2d89f1bc15a478c1c084a34b1f03',
     x86_64: '25cc290c3023077bcfb1bd40c84905f366561d7574dcfd8e890a1eea4c41e565',
  })

  depends_on 'bdwgc'
  depends_on 'gdk_pixbuf'
  depends_on 'imlib2'
  depends_on 'mailutils'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --with-imagelib='gdk-pixbuf imlib2' \
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
