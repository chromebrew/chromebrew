require 'package'

class Qtx11extras < Package
  description 'Provides classes for developing for the X11 platform.'
  homepage 'https://www.qt.io/'
  version '5.15.2'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'all'
  source_url 'https://download.qt.io/official_releases/qt/5.15/5.15.2/submodules/qtx11extras-everywhere-src-5.15.2.tar.xz'
  source_sha256 '7014702ee9a644a5a93da70848ac47c18851d4f8ed622b29a72eed9282fc6e3e'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtx11extras/5.15.2_armv7l/qtx11extras-5.15.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtx11extras/5.15.2_armv7l/qtx11extras-5.15.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtx11extras/5.15.2_i686/qtx11extras-5.15.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtx11extras/5.15.2_x86_64/qtx11extras-5.15.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '94135c37b7dab401960661ecc5474798f25d95f1677c3b56133770ba58d97f7c',
     armv7l: '94135c37b7dab401960661ecc5474798f25d95f1677c3b56133770ba58d97f7c',
       i686: '0741a8d65a3616d2473929f55a8689a1196277381227d63c49e1234acd25d6e7',
     x86_64: '817c1e82a88f71177f4d866f6629a84ad8e9683c682912cfb556714f0f60b603',
  })

  depends_on 'qtbase' => :build

  def self.build
    system 'qmake && make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r Dir['lib/*'], "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.cp_r 'include', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'src', "#{CREW_DEST_PREFIX}/share/Qt-5"
  end
end
