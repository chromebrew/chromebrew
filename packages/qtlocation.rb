require 'package'

class Qtlocation < Package
  description 'Qt Location and Positioning'
  homepage 'https://www.qt.io/'
  version '5.15.2'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'all'
  source_url 'https://download.qt.io/official_releases/qt/5.15/5.15.2/submodules/qtlocation-everywhere-src-5.15.2.tar.xz'
  source_sha256 '984fcb09e108df49a8dac35d5ce6dffc49caafd2acb1c2f8a5173a6a21f392a0'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtlocation/5.15.2_armv7l/qtlocation-5.15.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtlocation/5.15.2_armv7l/qtlocation-5.15.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtlocation/5.15.2_i686/qtlocation-5.15.2-chromeos-i686.tar.xz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtlocation/5.15.2_x86_64/qtlocation-5.15.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256 ({
    aarch64: '9a6a3a314c688a95fbec414902153b1e8ca11b6c4404098df89a4d07152b0984',
     armv7l: '9a6a3a314c688a95fbec414902153b1e8ca11b6c4404098df89a4d07152b0984',
       i686: 'bce4a0574c407d011896bb1728aaaaac67b573fcf8d1a8856819e75f80f00c36',
    x86_64: 'dcb8bae645b2c7acb5665a5732eae2fc8ec5824d3a8d395cabab50bbb799f04d'
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
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r Dir['lib/*'], "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.cp_r 'include', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'plugins', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'src', "#{CREW_DEST_PREFIX}/share/Qt-5"
  end
end
