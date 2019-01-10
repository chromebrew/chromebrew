require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '1.6.3'
  source_url 'https://download.filezilla-project.org/client/FileZilla_3.38.1_src.tar.bz2'
  source_sha256 '1a86becc4a8bb70ff316522217818364028b95224fc728e3bb676ebee98d0cde'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-1.6.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-1.6.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-1.6.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-1.6.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1d00ac0692973757937dfc29a9feed883b28e211ed700bda64d360e21d0cf5c8',
     armv7l: '1d00ac0692973757937dfc29a9feed883b28e211ed700bda64d360e21d0cf5c8',
       i686: '7157a9d2aa5899fcd9a21148f56daa3b01e70623d1d55d1256abf4e4043797f4',
     x86_64: '683cb597524c179fff8e0f2748a296d633c8429cdb948eaab70069609b2379f3',
  })

  depends_on 'dbus'
  depends_on 'gnome_icon_theme'
  depends_on 'hicolor_icon_theme'
  depends_on 'libfilezilla'
  depends_on 'libidn2'
  depends_on 'sqlite'
  depends_on 'wxwidgets'
  depends_on 'xdg_utils'
  depends_on 'sommelier'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--with-pugixml=builtin'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
