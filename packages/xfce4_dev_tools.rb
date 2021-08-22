require 'package'

class Xfce4_dev_tools < Package
  description 'Xfce4 development tools'
  homepage 'https://xfce.org/'
  version '4.17.0'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/xfce4-dev-tools/4.17/xfce4-dev-tools-4.17.0.tar.bz2'
  source_sha256 'd334c1f10e140e666b86c6c3bd8dcd62f1a877f537bcacc974478b6e92c493c7'

  depends_on 'gtk_doc'

  def self.patch
    system 'filefix'
  end

  def self.build
    system <<~BUILD
      # env NOCONFIGURE='1' ./autogen.sh
      env #{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}
      make
    BUILD
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
