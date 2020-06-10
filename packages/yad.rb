require 'package'

class Yad < Package
  description 'display graphical dialogs from shell scripts or command line.'
  homepage 'https://sourceforge.net/projects/yad-dialog/'
  version '0.40.0'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/yad-dialog/yad-0.40.0.tar.xz'
  source_sha256 'c2d0b7d1b6d3a0877299faa00db75d58c974f81fce72d520a3a84e67d1d60ef4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yad-0.40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yad-0.40.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yad-0.40.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yad-0.40.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9e95ee3627b04922ddd447649e69ea54c9dc43e7138319bd1588a4f8b58b51af',
     armv7l: '9e95ee3627b04922ddd447649e69ea54c9dc43e7138319bd1588a4f8b58b51af',
       i686: '6099dc7626511aa2c8e7dc55d0ed4ac516f165a5bd6c28a9b2170ca798aad445',
     x86_64: '1fdac4030f16b26ff16102a570c6d2ec58a5228fd8f89752e4e6da58555a6604',
  })

  depends_on 'gtk3'
  depends_on 'rgb'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--enable-gio',
           '--enable-icon-browser',
           '--with-gtk=gtk3',
           "--with-rgb=#{CREW_PREFIX}/share/X11/rgb.txt"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
