require 'package'

class Netsurf < Package
  description 'Free, open source web browser written in C'
  homepage 'https://www.netsurf-browser.org'
  version '3.10'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/netsurf/releases/source/netsurf-3.10-src.tar.gz'
  source_sha256 '36484429e193614685c2ff246f55bd0a6dddf31a018bee45e0d1f7c28851995e'

  depends_on 'netsurf_buildsystem'
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

 def self.build
  system "make -j#{CREW_NPROC} PREFIX=#{CREW_PREFIX}"
 end
 def self.install
  system "make -j#{CREW_NPROC} install PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
  system "ln -s /usr/local/bin/netsurf-gtk3 /usr/local/bin/netsurf"
 end
end
