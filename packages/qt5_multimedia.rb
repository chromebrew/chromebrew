require 'buildsystems/qmake'

class Qt5_multimedia < Qmake
  description 'Qt Multimedia'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '85fe63b98703ced6c5568c52af77b50e6ddf1edc'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtmultimedia.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '14b9edb627935207a061752dfac5b9d0a5c14b5c88c56dd59a715f8fa8558979',
     armv7l: '14b9edb627935207a061752dfac5b9d0a5c14b5c88c56dd59a715f8fa8558979',
     x86_64: '1610df59143ad7865b6df91ac26454350948717c2b18fcbccae77d1ae0abe02e'
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
