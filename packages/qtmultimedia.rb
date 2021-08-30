require 'package'

class Qtmultimedia < Package
  description 'Qt Multimedia'
  homepage 'https://www.qt.io/'
  version '5.15.2'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'all'
  source_url 'https://download.qt.io/official_releases/qt/5.15/5.15.2/submodules/qtmultimedia-everywhere-src-5.15.2.tar.xz'
  source_sha256 '0c3758810e5131aabcf76e4965e4c18b8911af54d9edd9305d2a8278d8346df5'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtmultimedia/5.15.2_armv7l/qtmultimedia-5.15.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtmultimedia/5.15.2_armv7l/qtmultimedia-5.15.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtmultimedia/5.15.2_i686/qtmultimedia-5.15.2-chromeos-i686.tar.xz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtmultimedia/5.15.2_x86_64/qtmultimedia-5.15.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256 ({
    aarch64: '01549aaf37a1c85ced9a7a8f796c9d085cf3a7f4f6197abf1af5afad24a72dfc',
     armv7l: '01549aaf37a1c85ced9a7a8f796c9d085cf3a7f4f6197abf1af5afad24a72dfc',
       i686: '47def7e00a23da3a6c138232a2a790a2dac7cbab0041dc57cae4dce06995f5da',
    x86_64: '0dbcb8550581fe3677df9ba03bed052a7dc1e513ddd83c7c40878684211b3379'
  })

  depends_on 'qtbase' => :build

  def self.build
    system 'qmake && make'
  end

  def self.install
    ENV['CREW_CONFLICTS_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Qt-5/plugins/mediaservice"
    FileUtils.cp_r Dir['lib/*'], CREW_DEST_LIB_PREFIX
    FileUtils.cp_r 'include', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'plugins', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'src', "#{CREW_DEST_PREFIX}/share/Qt-5"
  end
end
