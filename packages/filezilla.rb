require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.49.1'
  compatibility 'all'
  source_url 'https://download.filezilla-project.org/client/FileZilla_3.49.1_src.tar.bz2'
  source_sha256 '4ecc8c0cf1a790d17ba1daa3abdeeb999809548b20a804172ae0f80dd8e5b3b6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.49.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.49.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.49.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.49.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ed0be66719af2b0c5464df895c42145685e7de12210c2a8a946d2fcc76cc7d61',
     armv7l: 'ed0be66719af2b0c5464df895c42145685e7de12210c2a8a946d2fcc76cc7d61',
       i686: 'e0186c7d4b3668eea3b2beac65830a9787ed20ed2498bd72e140fb360bc7a801',
     x86_64: '74c0a8de788b4ea7dab339d8d856ba12ce3745a2b989067df0fbe3f0011d222c',
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
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode --with-pugixml=builtin"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
