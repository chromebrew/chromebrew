# Adapted from Arch Linux tracker3-miners PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tracker3-miners/trunk/PKGBUILD

require 'buildsystems/meson'

class Tracker3_miners < Meson
  description 'Collection of data extractors for Tracker/Nepomuk'
  homepage 'https://wiki.gnome.org/Projects/Tracker'
  version '3.6.2'
  license 'GPLv2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/tracker-miners.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '804efabc8139f777cd44c4fe5c61d33da4e9db56c81123119adf18e7c7455dd3',
     armv7l: '804efabc8139f777cd44c4fe5c61d33da4e9db56c81123119adf18e7c7455dd3',
     x86_64: '808e021c1c9c8fdd11792505ac551da9ffbfcb4dd632af4a8f03e4ea86817c90'
  })

  depends_on 'asciidoc' => :build
  depends_on 'exempi' # R
  depends_on 'gcc_lib' => :build
  depends_on 'gexiv2' # R
  depends_on 'giflib' # R
  depends_on 'glibc_lib' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'icu4c' # R
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

  gnome

  meson_options "-Ddbus_services_dir=#{CREW_PREFIX}/share/dbus-1/services/ \
      -Dbattery_detection=none \
      -Dman=false \
      -Dsystemd_user_services=false"
end
