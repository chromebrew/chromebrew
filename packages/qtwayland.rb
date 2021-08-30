require 'package'

class Qtwayland < Package
  description 'Qt Wayland'
  homepage 'https://www.qt.io/'
  version '5.15.2'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'all'
  source_url 'https://download.qt.io/official_releases/qt/5.15/5.15.2/submodules/qtwayland-everywhere-src-5.15.2.tar.xz'
  source_sha256 '193732229ff816f3aaab9a5e2f6bed71ddddbf1988ce003fe8dd84a92ce9aeb5'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwayland/5.15.2_armv7l/qtwayland-5.15.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwayland/5.15.2_armv7l/qtwayland-5.15.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwayland/5.15.2_i686/qtwayland-5.15.2-chromeos-i686.tar.xz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwayland/5.15.2_x86_64/qtwayland-5.15.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256 ({
    aarch64: 'f10467b273d72f146ac79a0e486790fb7212844f3a139d8a29e44c1f200c5d80',
     armv7l: 'f10467b273d72f146ac79a0e486790fb7212844f3a139d8a29e44c1f200c5d80',
       i686: 'c074b9aa753131f22492fffa91e84d89c066c2eb5c7ad9f1a37c9318e0c4feda',
    x86_64: 'ce44eafddf863bc16f8cfa6f740be79fd3573468c322e5ecd8e87d9c029d824b'
  })

  depends_on 'qtbase' => :build
  depends_on 'libxkbcommon'
  depends_on 'wayland'

  def self.build
    system 'qmake && make'
  end

  def self.install
    ENV['CREW_CONFLICTS_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r Dir['lib/*'], "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.cp_r 'bin', "#{CREW_DEST_PREFIX}"
    FileUtils.cp_r 'include', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'plugins', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'src', "#{CREW_DEST_PREFIX}/share/Qt-5"
  end
end
