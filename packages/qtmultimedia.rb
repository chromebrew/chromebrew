require 'package'

class Qtmultimedia < Package
  description 'Qt Multimedia'
  homepage 'https://www.qt.io/'
  version '5.15.9-ff4c7bc'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtmultimedia.git'
  git_hashtag 'ff4c7bc3bf7ba4b748fdeb9d09887271c2b28505'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtmultimedia/5.15.9-ff4c7bc_armv7l/qtmultimedia-5.15.9-ff4c7bc-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtmultimedia/5.15.9-ff4c7bc_armv7l/qtmultimedia-5.15.9-ff4c7bc-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtmultimedia/5.15.9-ff4c7bc_x86_64/qtmultimedia-5.15.9-ff4c7bc-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '83baafe7dddb17eef6de83f83b36b38713c34cad2b7a173ce9b481b52bfbe0ce',
     armv7l: '83baafe7dddb17eef6de83f83b36b38713c34cad2b7a173ce9b481b52bfbe0ce',
     x86_64: '0f8eb2171260fe8751c2bdc7ed03aa32a0990ff350179f396408c268ed880dbc'
  })

  depends_on 'alsa_lib' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'libglvnd' # R
  depends_on 'openal' # R
  depends_on 'pulseaudio' # R
  depends_on 'qtbase' # R
  depends_on 'qtdeclarative' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
