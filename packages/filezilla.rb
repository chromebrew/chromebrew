require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.39.0'
  source_url 'https://download.filezilla-project.org/client/FileZilla_3.39.0_src.tar.bz2'
  source_sha256 'fb515e93775e5ad94ff2755b39605b62b3e8fcfc1125757f411d8f580d16444f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.39.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.39.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.39.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.39.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7da4e0d6fc406bfd0e321ebd9058a2346ac50c182c62b201355be1c65f80e3f1',
     armv7l: '7da4e0d6fc406bfd0e321ebd9058a2346ac50c182c62b201355be1c65f80e3f1',
       i686: 'd6a0fd020e660b70bd64f1068c349e5cbe01e99255b9d931ad36d3b5c0937d06',
     x86_64: 'b3cd0a4569aa2396003683e824381f9856d1353fb79b47564f8887644b0cc170',
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
