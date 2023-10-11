# Adapted from Arch Linux tracker3-miners PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tracker3-miners/trunk/PKGBUILD

require 'buildsystems/meson'

class Tracker3_miners < Meson
  description 'Collection of data extractors for Tracker/Nepomuk'
  homepage 'https://wiki.gnome.org/Projects/Tracker'
  version '3.6.1'
  license 'GPLv2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/tracker-miners.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3_miners/3.6.1_armv7l/tracker3_miners-3.6.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3_miners/3.6.1_armv7l/tracker3_miners-3.6.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3_miners/3.6.1_x86_64/tracker3_miners-3.6.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '804efabc8139f777cd44c4fe5c61d33da4e9db56c81123119adf18e7c7455dd3',
     armv7l: '804efabc8139f777cd44c4fe5c61d33da4e9db56c81123119adf18e7c7455dd3',
     x86_64: '808e021c1c9c8fdd11792505ac551da9ffbfcb4dd632af4a8f03e4ea86817c90'
  })

  depends_on 'asciidoc' => :build
  depends_on 'exempi' # R
  depends_on 'gcc_lib' # R
  depends_on 'giflib' # R
  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'icu4c' # R
  depends_on 'libcue' => :build
  depends_on 'libcue' # R
  depends_on 'libexif' # R
  depends_on 'libgrss' # R
  depends_on 'libgsf' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libseccomp' # R
  depends_on 'libtiff' # R
  depends_on 'libxml2' # R
  depends_on 'poppler' # R
  depends_on 'tracker3' # R
  depends_on 'util_linux' # R
  depends_on 'vala' => :build

  meson_options "-Ddbus_services_dir=#{CREW_PREFIX}/share/dbus-1/services/ \
      -Dbattery_detection=none \
      -Dman=false \
      -Dsystemd_user_services=false"
end
