require 'package'

class Glib_networking < Package
  description 'Network extensions for GLib'
  homepage 'https://github.com/GNOME/glib-networking'
  version '2.57.3'
  compatibility 'all'
  source_url 'https://github.com/GNOME/glib-networking/archive/2.57.3.tar.gz'
  source_sha256 '7e45263dc9ece73e6370db4f61ccbac14a37f68d66f487417bc319e5f948a82d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib_networking-2.57.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib_networking-2.57.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib_networking-2.57.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib_networking-2.57.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f2a9ca1aa951dc280c405252f7a0d52fa61ff6f0d4452e2c91ee5e46d8d1221b',
     armv7l: 'f2a9ca1aa951dc280c405252f7a0d52fa61ff6f0d4452e2c91ee5e46d8d1221b',
       i686: 'e0e0e3327b782cb8a3e9126c7fa3264bdb5e006c30597da66438735087fa3e16',
     x86_64: '1cc6f98c79144848a68189470e195518348a997673a01474ec41f0cc63b72134',
  })

  depends_on 'libproxy'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'meson' => :build

  def self.build
    system 'meson builddir'
    system 'ninja -v -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
