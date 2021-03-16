require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.67.6'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  compatibility 'all'
  source_url "https://download.gnome.org/sources/glib/#{@_ver_prelastdot}/glib-#{@_ver}.tar.xz"
  source_sha256 'dd7f563509b410e8f94ef2d4cc7f74620a6b29d7c5d529fedec53c5e8018d9c5'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.6-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fe820f8369ab9c33f818bcd62e4a95bb8c5d28b7285a8781821ab25ec9ded416',
     armv7l: 'fe820f8369ab9c33f818bcd62e4a95bb8c5d28b7285a8781821ab25ec9ded416',
       i686: '26cc4995d5da3a24ef3fdbdc2135c086eedd12e59096f04ebe0e760e47f20657',
     x86_64: '74965074bd9480e0a8a9076bc9bdf092f5b97b47df74bf0a852ac16e1c5be208'
  })

  depends_on 'pcre'
  depends_on 'shared_mime_info'
  depends_on 'util_linux'
  depends_on 'six'
  depends_on 'pygments'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dc_args='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
    -Dc_link_args='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
    -Dcpp_args='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
    -Dcpp_link_args='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
    -Das_needed=false \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
