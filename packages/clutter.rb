require 'package'

class Clutter < Package
  description 'OpenGL based interactive canvas library'
  homepage 'https://www.clutter-project.org'
  version '1.26.4'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/clutter/1.26/clutter-1.26.4.tar.xz'
  source_sha256 '8b48fac159843f556d0a6be3dbfc6b083fc6d9c58a20a49a6b4919ab4263c4e6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/clutter-1.26.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/clutter-1.26.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/clutter-1.26.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/clutter-1.26.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a4d7168cb8e718e98ea86fe78993270536b07dd5c362de4961e16161ca61d3ea',
     armv7l: 'a4d7168cb8e718e98ea86fe78993270536b07dd5c362de4961e16161ca61d3ea',
       i686: '60f46fbd2e51468ae866556d61fa6779308b55b19063931ce2f5dc590c370eda',
     x86_64: '1fc7d581d9c66bf0d415cddf76e561428d8610513d41c89ed130a84e3acc605c',
  })

  depends_on 'atk'
  depends_on 'pango'
  depends_on 'libxi'
  depends_on 'libxcomposite'
  depends_on 'json_glib'
  depends_on 'libgudev'
  depends_on 'libxkbcommon'
  depends_on 'cogl'
  depends_on 'libinput'
  depends_on 'libevdev'
  depends_on 'eudev'
  depends_on 'pygtk'
  depends_on 'glib'
  depends_on 'xdg_base'

  def self.patch
    system "curl --ssl --progress-bar -o clutter-x11-startup-error.patch -L https://git.io/JU0yS"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('clutter-x11-startup-error.patch') ) == '8370bf0cf624c638edbd309d7dfc3922d726242312d7f217facff69135f56187'
    system "patch -Np0 < clutter-x11-startup-error.patch"
  end

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-evdev --enable-evdev-input --enable-wayland-backend --enable-egl-backend --enable-wayland-compositor --enable-gdk-backend"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
