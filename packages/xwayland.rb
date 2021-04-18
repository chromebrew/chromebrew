require 'package'

class Xwayland < Package
  description 'X server configured to work with weston or sommelier'
  homepage 'https://x.org'
  @_ver = '21.1.1'
  version @_ver
  license 'MIT-with-advertising, ISC, BSD-3, BSD and custom'
  compatibility 'all'
  source_url "https://xorg.freedesktop.org/archive/individual/xserver/xwayland-#{@_ver}.tar.xz"
  source_sha256 '31f261ce51bbee76a6ca3ec02aa367ffa2b5efa2b98412df57ccefd7a19003ce'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/xwayland-21.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/xwayland-21.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/xwayland-21.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/xwayland-21.1.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd8e3068e17a3870691209f2a72babe5b1e0e777851a39656dda132715227e81a',
     armv7l: 'd8e3068e17a3870691209f2a72babe5b1e0e777851a39656dda132715227e81a',
       i686: 'f49397108ca18335ee323d4f71a32d1041eb9747742185b361f1fbe7e9336b90',
     x86_64: '7c7f7d84957e4ab595458e5add13586bab6c45cb8edde948a9750aa02944f105'
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
  depends_on 'libxdmcp'
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
    system "meson configure #{CREW_MESON_OPTIONS} \
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
    # Get these from xorg_server package
    @deletefiles = %W[#{CREW_DEST_PREFIX}/bin/X #{CREW_DEST_MAN_PREFIX}/man1/Xserver.1]
    @deletefiles.each do |f|
      FileUtils.rm f if  File.exist?(f)
    end
  end
end
