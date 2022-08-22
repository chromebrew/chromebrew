require 'package'

class Qtsvg < Package
  description 'Provides classes for displaying the contents of SVG files.'
  homepage 'https://www.qt.io/'
  version '5.15.2'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'all'
  source_url 'https://download.qt.io/official_releases/qt/5.15/5.15.2/submodules/qtsvg-everywhere-src-5.15.2.tar.xz'
  source_sha256 '8bc3c2c1bc2671e9c67d4205589a8309b57903721ad14c60ea21a5d06acb585e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtsvg/5.15.2_armv7l/qtsvg-5.15.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtsvg/5.15.2_armv7l/qtsvg-5.15.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtsvg/5.15.2_i686/qtsvg-5.15.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtsvg/5.15.2_x86_64/qtsvg-5.15.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9427fc1458deeab6431d0dc728cbd49e960d87ff10df0526fd6e1b798423027d',
     armv7l: '9427fc1458deeab6431d0dc728cbd49e960d87ff10df0526fd6e1b798423027d',
       i686: 'e21dd221dd692cd6276c694a54cd2707a20828c36080fa23304a3e419a4ba849',
     x86_64: '531bdd88862e6bbe49aef6275ecef583df94f03daa0a94855ca0d99380af5e81'
  })

  depends_on 'qtbase' => :build

  def self.build
    system 'qmake && make'
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX.to_s
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r Dir['lib/*'], CREW_DEST_LIB_PREFIX.to_s
    FileUtils.cp_r 'include', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'plugins', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'src', "#{CREW_DEST_PREFIX}/share/Qt-5"
  end
end
