require 'package'

class Netsurf < Package
  description 'Free, open source web browser written in C'
  homepage 'https://www.netsurf-browser.org'
  version '3.10'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/netsurf/releases/source/netsurf-3.10-src.tar.gz'
  source_sha256 '36484429e193614685c2ff246f55bd0a6dddf31a018bee45e0d1f7c28851995e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/netsurf-3.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/netsurf-3.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/netsurf-3.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/netsurf-3.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6227ff3b0f01bfc07874340c33c598dfda687be81c0475f067a93c10ae0d14e4',
     armv7l: '6227ff3b0f01bfc07874340c33c598dfda687be81c0475f067a93c10ae0d14e4',
       i686: '571980948ef25797181f67dd7cf1977c0fd2d201a9ec7575c518082f3cb8fb6a',
     x86_64: '638661094c24e60ffbbd836af6e6c434c01c6e5aaa5c4003d59ace69e30edf99',
  })

  depends_on 'netsurf_buildsystem' => :build
  depends_on 'libidn2'
  depends_on 'libmng'
  depends_on 'libxml2'
  depends_on 'curl'
  depends_on 'lcms'
  depends_on 'libwebp'
  depends_on 'libcss'
  depends_on 'libnsbmp'
  depends_on 'libnsgif'
  depends_on 'utf8proc'
  depends_on 'desktop_file_utilities'
  depends_on 'libnsutils'
  depends_on 'libdom'
  depends_on 'pygtk'
  depends_on 'shared_mime_info'
  depends_on 'vim'
  depends_on 'nsgenbind'
  depends_on 'xdg_base'

  def self.patch
    system "sed -i 's,<libutf8proc/utf8proc.h>,<utf8proc.h>,' utils/idna.c"
  end

  def self.build
    system "make PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system "make install PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/netsurf-gtk3", "#{CREW_DEST_PREFIX}/bin/netsurf"
  end
end
