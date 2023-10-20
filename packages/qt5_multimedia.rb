require 'package'

class Qt5_multimedia < Package
  description 'Qt Multimedia'
  homepage 'https://www.qt.io/'
  version '5.15.11-f587b18'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtmultimedia.git'
  git_hashtag 'f587b18db4abd68cb6d4d77fbcec1b94c38d2a51' # from kde/5.15 branch

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_multimedia/5.15.11-f587b18_armv7l/qt5_multimedia-5.15.11-f587b18-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_multimedia/5.15.11-f587b18_armv7l/qt5_multimedia-5.15.11-f587b18-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_multimedia/5.15.11-f587b18_x86_64/qt5_multimedia-5.15.11-f587b18-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '682f5598df01442a3bde7ff5324bc3d43d1742e18cd24564fd4f26f51ee86a85',
     armv7l: '682f5598df01442a3bde7ff5324bc3d43d1742e18cd24564fd4f26f51ee86a85',
     x86_64: 'a2e7a9911878a22ed43e58840366b9300a69f264bb98253c34d5f8a33841dce2'
  })

  depends_on 'alsa_lib' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'libglvnd' # R
  depends_on 'openal' # R
  depends_on 'pulseaudio' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
