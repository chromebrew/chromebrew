require 'buildsystems/qmake'

class Qt5_websockets < Qmake
  description 'Qt Websockets'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '0231c7c3a17c0320601e7766e7e701db5b9eb0dc'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtwebsockets.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f2656344e2f7e71b9f170fe07e07eba45f5d5a9c29198af49d952127c3f3ec0d',
     armv7l: 'f2656344e2f7e71b9f170fe07e07eba45f5d5a9c29198af49d952127c3f3ec0d',
     x86_64: 'dfd957d60047987384111ca9ca35a8fdd87a93a5f8bc73ed3eb742280cf47efa'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end
