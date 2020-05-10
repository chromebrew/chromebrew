require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.46.3'
  compatibility 'all'
  source_url 'https://download.filezilla-project.org/client/FileZilla_3.46.3_src.tar.bz2'
  source_sha256 'f1c5bff0a99c39447a5ea9fdfcc16cc408876ef52fa8d5e7bf041ea0717a7395'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.46.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.46.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.46.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.46.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '47a8469458b831385a5120538a967ffe947d4e072c9075f19d0c9f15e4a2ccab',
     armv7l: '47a8469458b831385a5120538a967ffe947d4e072c9075f19d0c9f15e4a2ccab',
       i686: '2c1aa841ff739162478e8bef80097229f1fe66437db2fd41f6f517070c35116f',
     x86_64: '8f3c9199aa0dadec311daba0c0e1c0a06d407376a882da4e4468278b5d806b08',
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
