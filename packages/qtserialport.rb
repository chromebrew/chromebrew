require 'package'

class Qtserialport < Package
  description 'Qt Serial Port'
  homepage 'https://www.qt.io/'
  version '5.15.2'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'all'
  source_url 'https://download.qt.io/official_releases/qt/5.15/5.15.2/submodules/qtserialport-everywhere-src-5.15.2.tar.xz'
  source_sha256 '59c559d748417306bc1b2cf2315c1e63eed011ace38ad92946af71f23e2ef79d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtserialport/5.15.2_armv7l/qtserialport-5.15.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtserialport/5.15.2_armv7l/qtserialport-5.15.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtserialport/5.15.2_i686/qtserialport-5.15.2-chromeos-i686.tar.xz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtserialport/5.15.2_x86_64/qtserialport-5.15.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9f7347ae932bce62c32921f48f2918a74cc3fa0a806aff17cf63d4e32cb2ae56',
     armv7l: '9f7347ae932bce62c32921f48f2918a74cc3fa0a806aff17cf63d4e32cb2ae56',
       i686: 'fdde905da3e5a1f8fc4e1147b4f23062e1a66a00b125a6455e25c090c62b6997',
    x86_64: '2bee9643b08bfb38e5dd4d4dab07114c8798d260cb24451400cfda50e2c2f2c8'
  })

  depends_on 'qtbase' => :build

  def self.build
    system 'qmake && make'
  end

  def self.install
    ENV['CREW_CONFLICTS_ONLY_ADVISORY'] = '1'
    reload_constants
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX.to_s
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r Dir['lib/*'], CREW_DEST_LIB_PREFIX.to_s
    FileUtils.cp_r 'include', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'src', "#{CREW_DEST_PREFIX}/share/Qt-5"
  end
end
