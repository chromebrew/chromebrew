require 'package'

class Gtk_engines_adwaita < Package
  description 'Adwaita GTK+2 theme engine.'
  homepage 'https://git.gnome.org/browse/gnome-themes-standard/'
  version '3.27.92'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://github.com/GNOME/gnome-themes-extra/archive/3.27.92.tar.gz'
    source_sha256 'c2c2b02e6826d51de4e6e53afffbdb0ec301ef776df91944574fdc42b558cecb'
    depends_on 'gtk3'
    depends_on 'gtk2'
    depends_on 'librsvg'
    depends_on 'gdk_pixbuf'
    depends_on 'cairo'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk_engines_adwaita-3.27.92-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk_engines_adwaita-3.27.92-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk_engines_adwaita-3.27.92-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e5b8a68fcf3d91a95867f727e788b51575cf919b794877cca8e34b5e582ebfee',
     armv7l: 'e5b8a68fcf3d91a95867f727e788b51575cf919b794877cca8e34b5e582ebfee',
     x86_64: '403ef26ed4d75165d0e5133af688555f6d076ed662f4ccab8ec301b7dd1de60f',
  })

  def self.build
    system 'sh autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install' # the steps required to install the package
  end
end
