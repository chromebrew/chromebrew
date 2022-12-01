# Adapted from Arch Linux tracker3-miners PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tracker3-miners/trunk/PKGBUILD

require 'package'

class Tracker3_miners < Package
  description 'Collection of data extractors for Tracker/Nepomuk'
  homepage 'https://wiki.gnome.org/Projects/Tracker'
  version '3.4.0.rc'
  license 'GPLv2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/tracker-miners/-/archive/#{version}/tracker-miners-#{version}.tar.bz2"
  source_sha256 '85dd84e76803d2df0c7cab8ee82c32ce0349f9784039571604dc4def00dfa85d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3_miners/3.4.0.rc_armv7l/tracker3_miners-3.4.0.rc-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3_miners/3.4.0.rc_armv7l/tracker3_miners-3.4.0.rc-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3_miners/3.4.0.rc_i686/tracker3_miners-3.4.0.rc-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3_miners/3.4.0.rc_x86_64/tracker3_miners-3.4.0.rc-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6b156051e5c37973ebe6d36e3cf9cea32823837c708918395a8be139101847bc',
     armv7l: '6b156051e5c37973ebe6d36e3cf9cea32823837c708918395a8be139101847bc',
       i686: '52db658c8903f7ad1d2586627438326265353e54ea6d7e956aba07e2e5a277d5',
     x86_64: 'e7799b7a989501ce2fa23203becdae5a174747c4f6ca563d0e2c7e50646b1dfa'
  })

  depends_on 'asciidoc' => :build
  depends_on 'exempi' # R
  depends_on 'gcc' # R
  depends_on 'giflib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gstreamer' # R
  depends_on 'icu4c' # R
  depends_on 'libcue' => :build
  depends_on 'libexif' # R
  depends_on 'libgrss' # R
  depends_on 'libgsf' # R
  depends_on 'libjpeg'
  depends_on 'libpng' # R
  depends_on 'libseccomp' # R
  depends_on 'libtiff' # R
  depends_on 'libxml2' # R
  depends_on 'tracker3' # R
  depends_on 'vala' => :build
  depends_on 'util_linux' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Ddbus_services_dir=#{CREW_PREFIX}/share/dbus-1/services/ \
      -Dman=false \
      -Dsystemd_user_services=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
