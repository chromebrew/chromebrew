require 'package'

class Qtwebglplugin < Package
  description 'Qt WebGL Plugin'
  homepage 'https://www.qt.io/'
  version '5.15.9'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwebglplugin.git'
  git_hashtag "v#{version}-lts-lgpl"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwebglplugin/5.15.9_armv7l/qtwebglplugin-5.15.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwebglplugin/5.15.9_armv7l/qtwebglplugin-5.15.9-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwebglplugin/5.15.9_x86_64/qtwebglplugin-5.15.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a5afc0d6f1f78bcad7e14933549f1dd75cd9f4b7e0e5cff5a49603ea25daa01f',
     armv7l: 'a5afc0d6f1f78bcad7e14933549f1dd75cd9f4b7e0e5cff5a49603ea25daa01f',
     x86_64: '72d153c0e855fe322ebd9084902469f9353a33bff5d53ab945be096692ce1291'
  })

  depends_on 'qt5_base' # R
  depends_on 'qtwebsockets' # R

  def self.build
    system 'qmake && make'
  end

  def self.install
    system 'make', "prefix=#{CREW_PREFIX}", "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
  end
end
