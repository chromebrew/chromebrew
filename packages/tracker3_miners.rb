# Adapted from Arch Linux tracker3-miners PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tracker3-miners/trunk/PKGBUILD

require 'package'

class Tracker3_miners < Package
  description 'Collection of data extractors for Tracker/Nepomuk'
  homepage 'https://wiki.gnome.org/Projects/Tracker'
  version '3.1.0'
  license 'GPLv2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/tracker-miners/-/archive/#{version}/tracker-miners-#{version}.tar.bz2"
  source_sha256 '4384105303082b859c48eec1fdb19b905e7605bba901cbc09df779293c319460'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/tracker3_miners-3.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/tracker3_miners-3.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/tracker3_miners-3.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/tracker3_miners-3.1.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0809348f22bc74b6af7e5e1566017feee21c2094cc6cc338d0ac070a1eba3931',
     armv7l: '0809348f22bc74b6af7e5e1566017feee21c2094cc6cc338d0ac070a1eba3931',
       i686: 'c358f7e2a05d3f3cae8dfa09bf48fcaaaa4fb1b5c2eef23602a49832faaeaa03',
     x86_64: '3fce496bea0b469198d0994c959c981fa18d9cd0541cd14dad5568fed7701c72'
  })

  depends_on 'asciidoc' => :build
  depends_on 'exempi'
  depends_on 'giflib'
  depends_on 'glib'
  depends_on 'gst_plugins_base'
  depends_on 'gstreamer'
  depends_on 'libcue'
  depends_on 'libexif'
  depends_on 'libgrss'
  depends_on 'libgsf'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'tracker3'
  depends_on 'vala' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Ddbus_services_dir=#{CREW_PREFIX}/share/dbus-1/services/ \
      -Ddocs=false \
      -Dman=false \
      -Dsystemd_user_services=false \
      -Dtest_utils=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
