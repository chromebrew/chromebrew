require 'package'

class Qt5_multimedia < Package
  description 'Qt Multimedia'
  homepage 'https://www.qt.io/'
  version '5.15.11-f587b18'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtmultimedia.git'
  git_hashtag 'f587b18db4abd68cb6d4d77fbcec1b94c38d2a51' # from kde/5.15 branch

  binary_url({})
  binary_sha256({})

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
