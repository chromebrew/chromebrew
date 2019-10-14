require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.43.0'
  source_url 'https://download.filezilla-project.org/client/FileZilla_3.43.0_src.tar.bz2'
  source_sha256 '6fe652c360682f860abe2dc2e196bddca6260242cefe6fe779d42c327c01258e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.43.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.43.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.43.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.43.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fdef2404efb7251ba6c9b3675d6f7364b57272cc8c431e8de69761224bae5f9d',
     armv7l: 'fdef2404efb7251ba6c9b3675d6f7364b57272cc8c431e8de69761224bae5f9d',
       i686: '652990bad986fc083e5d9137bf9df6bba7479ca8ec255a9250c34680b5676610',
     x86_64: '3fe771c921d4738d0c82d33bfd0aeea1405009ce0ea7d126603801f40abec1ee',
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
