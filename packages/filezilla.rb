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
     aarch64: '09d27595590ea5d0e3a31b943a34962c8ec9314e8c3628472cb69f0c98bb3a25',
      armv7l: '09d27595590ea5d0e3a31b943a34962c8ec9314e8c3628472cb69f0c98bb3a25',
        i686: '731e2488ce0d5024b3f2ae8874dce80e2826d5aa6aefbb92b808e1ac08fafab9',
      x86_64: 'a2bcd8daeca485ef2695b1eac1490cebb9cfa1d740d20e20ecacffb869451403',
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
  depends_on 'libwebp'

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
