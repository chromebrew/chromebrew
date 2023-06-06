require 'package'

class Glib_networking < Package
  description 'Network extensions for GLib'
  homepage 'https://github.com/GNOME/glib-networking'
  version '2.76.0'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib-networking.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib_networking/2.76.0_armv7l/glib_networking-2.76.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib_networking/2.76.0_armv7l/glib_networking-2.76.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib_networking/2.76.0_i686/glib_networking-2.76.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib_networking/2.76.0_x86_64/glib_networking-2.76.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6aae918087e530ebfa96240e4fb62fbc6bb4bea47abd2729457d31557d2a9808',
     armv7l: '6aae918087e530ebfa96240e4fb62fbc6bb4bea47abd2729457d31557d2a9808',
       i686: '944bda7a386f5851ad861ed06cb54b0a3c7fc68e0af505f930a2bf801a359884',
     x86_64: 'eba4a6f591b61f4258112e5a9a8c5f0c90019e0749398890ed33db281160ad1b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnutls' # R
  depends_on 'gsettings_desktop_schemas'
  depends_on 'libproxy'

  gnome

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
