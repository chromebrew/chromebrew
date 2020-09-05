require 'package'

class Gcr < Package
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  version '3.36.0'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/gcr/3.36/gcr-3.36.0.tar.xz'
  source_sha256 'aaf9bed017a2263c6145c89a1a84178f9f40f238426463e4ae486694ef5f6601'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gcr-3.36.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gcr-3.36.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gcr-3.36.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e0830fd1ebb83ec32587d1c299565262c0af0b1d8ea893f3d92572b3b44d85df',
     armv7l: 'e0830fd1ebb83ec32587d1c299565262c0af0b1d8ea893f3d92572b3b44d85df',
     x86_64: '9417383cdb622492605252348a7b966041fbfea37d52d8467f9c8328e6d2050c',
  })

  depends_on 'pygtk'
  depends_on 'libgcrypt'
  depends_on 'libxslt'
  depends_on 'desktop_file_utilities'
  depends_on 'hicolor_icon_theme'
  depends_on 'gnupg'
  depends_on 'glib'
  depends_on 'gnupg'
  depends_on 'libxslt'
  depends_on 'vala' => :build

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} _build -Dgtk_doc=false" # Due to issues with gtk_doc it has been disabled; I will revist this when gtk_doc is fixed
    system 'ninja -v -C _build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
