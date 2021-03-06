require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.67.5'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  compatibility 'all'
  source_url "https://download.gnome.org/sources/glib/#{@_ver_prelastdot}/glib-#{@_ver}.tar.xz"
  source_sha256 '9d2ad4303ce25ae7cfde77409d8364508ac6072a868cfca2e78333c6cdfa05e6'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'bde7d35943c70e260e52a3688ba88e114717e461bad41b5c90942f46205345c2',
     armv7l: 'bde7d35943c70e260e52a3688ba88e114717e461bad41b5c90942f46205345c2',
       i686: '2ac0cb8ac4a6b92ff84a31f670b1d915b95137d797778ea962fa143dd1c9df81',
     x86_64: '5e5ac89b2b53a90b34da77fe8b26dece4c30c4c772a6232eb229751307bf4cef'
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
