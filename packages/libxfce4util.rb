require 'package'

class Libxfce4util < Package
  description 'Utility library for the Xfce4 desktop environment'
  homepage 'https://xfce.org/'
  version '4.16.0'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/libxfce4util/4.16/libxfce4util-4.16.0.tar.bz2'
  source_sha256 '60598d745d1fc81ff5ad3cecc3a8d1b85990dd22023e7743f55abd87d8b55b83'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4util-4.16.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4util-4.16.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4util-4.16.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4util-4.16.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ceca4f8f984045af5c7d945c679884e034ccbe005b778ad51bb957cf59c00cc8',
     armv7l: 'ceca4f8f984045af5c7d945c679884e034ccbe005b778ad51bb957cf59c00cc8',
       i686: '6bd36fee5ba039cfd4eeba7d35dd8518d077c8ff7ab3655592a47c2d3b1f6f4a',
     x86_64: '077a6ddd98402bced4c6269ce7374452ef3709a4c821565c643108ccb8c3cd8e',
  })

  depends_on 'gobject_introspection'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
