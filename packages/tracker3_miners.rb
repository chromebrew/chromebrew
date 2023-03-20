# Adapted from Arch Linux tracker3-miners PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tracker3-miners/trunk/PKGBUILD

require 'package'

class Tracker3_miners < Package
  description 'Collection of data extractors for Tracker/Nepomuk'
  homepage 'https://wiki.gnome.org/Projects/Tracker'
  version '3.5.0'
  license 'GPLv2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/tracker-miners/-/archive/#{version}/tracker-miners-#{version}.tar.bz2"
  source_sha256 '6bc573140e379ef1fd9040adcda234fd8da6586622878a67f0f4ec75bd2cc170'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3_miners/3.5.0_armv7l/tracker3_miners-3.5.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3_miners/3.5.0_armv7l/tracker3_miners-3.5.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3_miners/3.5.0_x86_64/tracker3_miners-3.5.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '44885f8b09a3d7469b7fdee754ce9893dd1103680d6e83bc0134180ee74844d6',
     armv7l: '44885f8b09a3d7469b7fdee754ce9893dd1103680d6e83bc0134180ee74844d6',
     x86_64: '5b1961229a1ef4284241dbc6b2f9ca1487f6daf841f0a027d3f24b3abf781213'
  })

  depends_on 'asciidoc' => :build
  depends_on 'exempi' # R
  depends_on 'gcc' # R
  depends_on 'giflib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'icu4c' # R
  depends_on 'libcue' => :build
  depends_on 'libexif' # R
  depends_on 'libgrss' # R
  depends_on 'libgsf' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libseccomp' # R
  depends_on 'libtiff' # R
  depends_on 'libxml2' # R
  depends_on 'tracker3' # R
  depends_on 'util_linux' # R
  depends_on 'vala' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Ddbus_services_dir=#{CREW_PREFIX}/share/dbus-1/services/ \
      -Dbattery_detection=none \
      -Dman=false \
      -Dsystemd_user_services=false \
      builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
