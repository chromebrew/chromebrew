require 'package'

class Xwayland < Package
  description 'X server configured to work with weston or sommelier'
  homepage 'https://x.org'
  @_ver = '21.1.1'
  version "#{@_ver}-1"
  license 'MIT-with-advertising, ISC, BSD-3, BSD and custom'
  compatibility 'all'
  source_url "https://xorg.freedesktop.org/archive/individual/xserver/xwayland-#{@_ver}.tar.xz"
  source_sha256 '31f261ce51bbee76a6ca3ec02aa367ffa2b5efa2b98412df57ccefd7a19003ce'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xwayland/21.1.1-1_armv7l/xwayland-21.1.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xwayland/21.1.1-1_armv7l/xwayland-21.1.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xwayland/21.1.1-1_i686/xwayland-21.1.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xwayland/21.1.1-1_x86_64/xwayland-21.1.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '38b5d8f88eeebfc129228ba922d1e50c9744603fa8ea1d1b140a3f8febeb44b0',
     armv7l: '38b5d8f88eeebfc129228ba922d1e50c9744603fa8ea1d1b140a3f8febeb44b0',
       i686: '6013786072753462890a811aa56bd491e459395133f45ac9914bd1f4b6ea07ac',
     x86_64: 'ff1faf9120fd8b815a14cacac97efeb788a5a834b7527b2fb6300e533c3c611d'
  })

  depends_on 'dbus'
  depends_on 'eudev'
  depends_on 'font_util'
  depends_on 'glproto'
  depends_on 'graphite'
  depends_on 'libbsd' # R
  depends_on 'libdrm' # R
  depends_on 'libepoxy' # R
  depends_on 'libtirpc' => :build
  depends_on 'libunwind'  => :build
  depends_on 'libxau' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxfont2' # R
  depends_on 'libxfont' # R
  depends_on 'libxkbcommon'
  depends_on 'libxkbfile' # R
  depends_on 'libxshmfence' # R
  depends_on 'libxtrans'
  depends_on 'mesa' # R
  depends_on 'pixman' # R
  depends_on 'wayland' # R
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
