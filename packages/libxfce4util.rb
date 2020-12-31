require 'package'

class Libxfce4util < Package
  description 'Utility library for the Xfce4 desktop environment'
  homepage 'https://xfce.org/'
  version '4.16.0'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/libxfce4util/4.16/libxfce4util-4.16.0.tar.bz2"
  source_sha256 '60598d745d1fc81ff5ad3cecc3a8d1b85990dd22023e7743f55abd87d8b55b83'

  depends_on 'gobject_introspection'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
