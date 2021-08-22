require 'package'

class Libxfce4util < Package
  description 'Utility library for the Xfce4 desktop environment'
  homepage 'https://xfce.org/'
  version '4.16.0'
  license 'LGPL-2+ and GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.xfce.org/xfce/libxfce4util.git'
  git_hashtag '546a8404050459a7b4d5bd264d11d1748f71d940'

  depends_on 'gobject_introspection'

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
