require 'package'

class Xmlcatmgr < Package
  description 'XML and SGML catalog manager'
  homepage 'https://xmlcatmgr.sourceforge.net'
  version '2.2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/sourceforge/xmlcatmgr/xmlcatmgr-2.2.tar.gz'
  source_sha256 'ea1142b6aef40fbd624fc3e2130cf10cf081b5fa88e5229c92b8f515779d6fdc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xmlcatmgr-2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xmlcatmgr-2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xmlcatmgr-2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xmlcatmgr-2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '24f525796676d285347f300bb26b60c728d6384032e0dad2230bc0c4bbb41eea',
     armv7l: '24f525796676d285347f300bb26b60c728d6384032e0dad2230bc0c4bbb41eea',
       i686: '656fb01f7e1e1f7c78b4f389d7bd80404a26333d23eb257517972d167952e439',
     x86_64: 'b7942cbf386adb0b43116c5f041ff97a3c2c7202687a0a03575e498e0b8d43b1',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
