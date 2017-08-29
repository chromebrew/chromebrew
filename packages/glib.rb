require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib/'
  version '2.40.2-1'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glib/2.40/glib-2.40.2.tar.xz'
  source_sha256 'e8ff8af2950897e805408480c454c415d1eade4e670ec5fb507f5e5853726c7a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.40.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.40.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.40.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.40.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2dac85fcc4af6d049cee58cee774c644f3c7374b53344c62e62f6de90d99784e',
     armv7l: '2dac85fcc4af6d049cee58cee774c644f3c7374b53344c62e62f6de90d99784e',
       i686: '60e5ff58390596269e5690219afbc37f4c7a3f0808244e8b438ffa787c3deb3c',
     x86_64: '3e14b78664198a520486af445ef0ed5a4650d7bbf22bb6e5d1f16c13c3fc7e15',
  })

  depends_on 'libffi'
  depends_on 'gettext'
  depends_on 'zlibpkg'
  depends_on 'python27'

  def self.build
    system "./configure --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
