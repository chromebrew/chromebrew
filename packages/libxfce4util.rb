require 'package'

class Libxfce4util < Package
  description 'Utility library for the Xfce4 desktop environment'
  homepage 'https://xfce.org/'
  version '4.17.1'
  license 'LGPL-2+ and GPL-2+'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/libxfce4util/4.17/libxfce4util-4.17.1.tar.bz2'
  source_sha256 '1942151f3c1f3732bc53dd9fd3b936f62067796dc47a33c60a0ad05d933d90f2'

  depends_on 'gobject_introspection'

  def self.patch
    system 'filefix'
  end

  def self.build
    system <<~BUILD
      [ -x autogen.sh ] && env NOCONFIGURE='1' ./autogen.sh
      env #{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}
      make
    BUILD
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
