require 'package'

class Qtwayland < Package
  description 'Qt Wayland'
  homepage 'https://www.qt.io/'
  version '5.15.7-206ee84'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/qt/qt/qtwayland.git'
  git_hashtag '206ee84d640b4160c25c95aeb26197743d533397'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwayland/5.15.7-206ee84_armv7l/qtwayland-5.15.7-206ee84-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwayland/5.15.7-206ee84_armv7l/qtwayland-5.15.7-206ee84-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwayland/5.15.7-206ee84_i686/qtwayland-5.15.7-206ee84-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwayland/5.15.7-206ee84_x86_64/qtwayland-5.15.7-206ee84-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '47ce8d7b498dae5f361e230b2244d79e869e01f472be711066bb38a8caf179a9',
     armv7l: '47ce8d7b498dae5f361e230b2244d79e869e01f472be711066bb38a8caf179a9',
       i686: 'bd7f65746921f5dc965a8c7ce38a637477bc099e7b5a487a57944506faf08737',
     x86_64: '4cd2a3d72e5a1c0c532db053f8de60250db1ac9f01b48436b7df8917f2945190'
  })

  depends_on 'freetype' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'harfbuzz' # R
  depends_on 'libdrm' # R
  depends_on 'libglvnd' # R
  depends_on 'libx11' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxext' # R
  depends_on 'libxkbcommon' # R
  depends_on 'qtbase' # R
  depends_on 'wayland' # R
  depends_on 'zlibpkg' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
