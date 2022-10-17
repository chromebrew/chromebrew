require 'package'

class Qtscript < Package
  description 'Qt Script Tools'
  homepage 'https://www.qt.io/'
  version '5.15.2'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'all'
  source_url 'https://download.qt.io/official_releases/qt/5.15/5.15.2/submodules/qtscript-everywhere-src-5.15.2.tar.xz'
  source_sha256 'a299715369afbd1caa4d7fa2875d442eab91adcaacafce54a36922442624673e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtscript/5.15.2_armv7l/qtscript-5.15.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtscript/5.15.2_armv7l/qtscript-5.15.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtscript/5.15.2_i686/qtscript-5.15.2-chromeos-i686.tar.xz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtscript/5.15.2_x86_64/qtscript-5.15.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '06b278711c766791239426fd5ea21d1c3c5ae307c239f5de82624cdf31f2cc58',
     armv7l: '06b278711c766791239426fd5ea21d1c3c5ae307c239f5de82624cdf31f2cc58',
       i686: 'fc36e61344b6596119223f4d417abe9ae732267b7fb7a6011ed703ed33f6bb80',
    x86_64: '44a88b839b944e50a22cf6a77bc63eb41286fc5c1978cd6af39a2f954313c09a'
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
