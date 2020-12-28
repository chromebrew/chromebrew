require 'package'
  
class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.51.0'
  compatibility 'all'
  source_url 'https://download.filezilla-project.org/client/FileZilla_3.51.0_src.tar.bz2'
  source_sha256 '82be1c4a4f51bb32a599d0b4cc3a24127ba948c0af0f957233cc6a13ea3b6c4c'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.51.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.51.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.51.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.51.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '16f8dcf227c393a4f408656cb10e1d5c14144dc1bdd89a6fc5e5ba50fef8e7c8',
      armv7l: '16f8dcf227c393a4f408656cb10e1d5c14144dc1bdd89a6fc5e5ba50fef8e7c8',
        i686: '20a8a674b2aa6f1d9358848de435a715bd8c5ff37558107d4f87d11c865be10d',
      x86_64: '95c2ca352901e85f2450b65b92c0868ece5120e5a02f20194d768d5f915cf731',
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

  def self.patch
    system 'filefix'
  end

  def self.build
    ENV['CC'] = 'gcc'
    ENV['CXX'] = 'g++'
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode --with-pugixml=builtin"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
