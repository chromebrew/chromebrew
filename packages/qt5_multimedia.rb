require 'buildsystems/qmake'

class Qt5_multimedia < Qmake
  description 'Qt Multimedia'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = 'b7c7ff4ab8c0f43a03de51a76867aae691411410'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtmultimedia.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     x86_64: 'cd34401cc3a10ca21e3903097571d69e1ab68f8262962686d93b2c96bdd5074c'
  })

  depends_on 'alsa_lib' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gstreamer' # R
  depends_on 'libdrm' # R
  depends_on 'libglvnd' # R
  depends_on 'openal' # R
  depends_on 'pulseaudio' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end
