require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.68.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://download.gnome.org/sources/glib/#{@_ver_prelastdot}/glib-#{@_ver}.tar.xz"
  source_sha256 '67734f584f3a05a2872f57e9a8db38f3b06c7087fb531c5a839d9171968103ea'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.68.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.68.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.68.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.68.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '074bbda5881173ce7d9cb01849cd9c1919ff3e111e3d40c4abbe655b1de6aa55',
     armv7l: '074bbda5881173ce7d9cb01849cd9c1919ff3e111e3d40c4abbe655b1de6aa55',
       i686: '4b4236243277ef9e2e1671090b9c5eb761fcbc1f4df43cbe54cffe19f838a922',
     x86_64: '7c2bca7c57a8552eb0be3bac923d984eb01449d329b4d1a061b2dc42aacece82'
  })

  depends_on 'pcre'
  depends_on 'shared_mime_info'
  depends_on 'util_linux'
  depends_on 'six'
  depends_on 'py3_pygments'

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
