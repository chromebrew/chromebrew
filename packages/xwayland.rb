require 'package'

class Xwayland < Package
  description 'X server configured to work with weston or sommelier'
  homepage 'https://x.org'
  @_ver = '21.1.0'
  version @_ver
  compatibility 'all'
  source_url "https://xorg.freedesktop.org/archive/individual/xserver/xwayland-#{@_ver}.tar.xz"
  source_sha256 '8a71c3e8b95c43bb91bc3d7a4ff9075456a0cfe297721dbc8d4a76cf241d82fb'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xwayland-21.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xwayland-21.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xwayland-21.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xwayland-21.1.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c6951e26f866c161171598257d8f56ee94ca180d2d3dfb45d92871be230050eb',
     armv7l: 'c6951e26f866c161171598257d8f56ee94ca180d2d3dfb45d92871be230050eb',
       i686: 'aec35c04079a6187f9e637d09715bbea03343dded024672693cf6f49c21bd180',
     x86_64: '584edc98ad46aa38da43d5174d533e4407b68f5f8fe7608a98bbcba72912c3e4'
  })

  depends_on 'dbus'
  depends_on 'eudev'
  depends_on 'font_util'
  depends_on 'glproto'
  depends_on 'graphite'
  depends_on 'libbsd'
  depends_on 'libepoxy'
  depends_on 'libunwind'
  depends_on 'libxfont'
  depends_on 'libxkbcommon'
  depends_on 'libxkbfile'
  depends_on 'libxtrans'
  depends_on 'lzma' => :build
  depends_on 'mesa'
  depends_on 'pixman'
  depends_on 'wayland'
  depends_on 'xkbcomp'
  depends_on 'xorg_lib'

  case ARCH
  when 'armv7l', 'aarch64'
    PEER_CMD_PREFIX = '/lib/ld-linux-armhf.so.3'.freeze
  when 'i686'
    PEER_CMD_PREFIX = '/lib/ld-linux-i686.so.2'.freeze
  when 'x86_64'
    PEER_CMD_PREFIX = '/lib64/ld-linux-x86-64.so.2'.freeze
  end

  def self.build
    system 'meson setup build'
    system "meson configure #{CREW_MESON_LTO_OPTIONS} \
              -Db_asneeded=false \
              -Dipv6=true \
              -Dxvfb=true \
              -Dxcsecurity=true \
              -Dglamor=true \
              build"
    system 'meson configure build'
    system 'ninja -C build'
    system "cat <<'EOF'> Xwayland_sh
#!/bin/bash
if base=$(readlink \"$0\" 2>/dev/null); then
  case $base in
  /*) base=$(readlink -f \"$0\" 2>/dev/null);; # if $0 is abspath symlink, make symlink fully resolved.
  *)  base=$(dirname \"$0\")/\"${base}\";;
  esac
else
  case $0 in
  /*) base=$0;;
  *)  base=${PWD:-`pwd`}/$0;;
  esac
fi
basedir=${base%/*}
# TODO(crbug/1003841): Remove LD_ARGV0 once
# ld.so supports forwarding the binary name.
LD_ARGV0=\"$0\" LD_ARGV0_REL=\"../bin/Xwayland.sh\" exec   \"${basedir}/..#{PEER_CMD_PREFIX}\"   --library-path \"${basedir}/../#{ARCH_LIB}\"   --inhibit-rpath ''   \"${base}.elf\"   \"$@\"
EOF"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/Xwayland", "#{CREW_DEST_PREFIX}/bin/Xwayland.elf"
    system "install -Dm755 Xwayland_sh #{CREW_DEST_PREFIX}/bin/Xwayland"
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/Xwayland", "#{CREW_DEST_PREFIX}/bin/X"
  end
end
