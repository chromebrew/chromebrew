require 'package'

class Xorg_server < Package
  description 'The Xorg Server is the core of the X Window system.'
  homepage 'https://www.x.org'
  @_ver = '1.20.10'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://github.com/freedesktop/xorg-xserver/archive/xorg-server-#{@_ver}.tar.gz"
  source_sha256 '499d2b79fdf78e2e06b0c17a4d735fe25ba9d44f689e06a7e82612c35083c4ad'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.20.10-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.20.10-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.20.10-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.20.10-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0ce4d77d557a5cc438e7257c157584eb8d2e62f88a250e3f0abd1d35e5f76154',
     armv7l: '0ce4d77d557a5cc438e7257c157584eb8d2e62f88a250e3f0abd1d35e5f76154',
       i686: '1886cb710830cb55660b407c9bcc31b8a1ca85dad3115778ea561fd46b673f19',
     x86_64: '5cc436f10f8c8219284b629597f912d08ebeb1a221ebb16dbe97902a4045f706'
  })

  depends_on 'libepoxy'
  depends_on 'libxtrans'
  depends_on 'libxkbfile'
  depends_on 'wayland'
  depends_on 'eudev'
  depends_on 'libxfont'
  depends_on 'libbsd'
  depends_on 'pixman'
  depends_on 'graphite'
  depends_on 'libxkbcommon'
  depends_on 'libunwind'
  depends_on 'font_util'
  depends_on 'xorg_lib'
  depends_on 'font_util'
  depends_on 'libbsd'
  depends_on 'dbus'
  depends_on 'lzma' => :build
  depends_on 'xkbcomp'
  depends_on 'glproto'
  depends_on 'xcb_util_renderutil' => :build
  depends_on 'xcb_util_image' => :build
  depends_on 'xcb_util_keysyms' => :build
  depends_on 'xcb_util_wm' => :build
  depends_on 'xcb_util_xrm' => :build
  depends_on 'xcb_util_cursor' => :build
  depends_on 'mesa'

  case ARCH
  when 'armv7l', 'aarch64'
    @peer_cmd_prefix = '/lib/ld-linux-armhf.so.3'
  when 'i686'
    @peer_cmd_prefix = '/lib/ld-linux-i686.so.2'
  when 'x86_64'
    @peer_cmd_prefix = '/lib64/ld-linux-x86-64.so.2'
  end

  def self.build
    system 'meson setup build'
    system "meson configure #{CREW_MESON_LTO_OPTIONS} \
              -Db_asneeded=false \
              -Dipv6=true \
              -Dxvfb=true \
              -Dxnest=true \
              -Dxcsecurity=true \
              -Dxorg=true \
              -Dxephyr=true \
              -Dxwayland=true \
              -Dglamor=true \
              -Dudev=true \
              -Dxwin=false \
              -Dsystemd_logind=false \
              -Dint10=auto \
              -Dlog_dir=#{CREW_PREFIX}/var/log \
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
LD_ARGV0=\"$0\" LD_ARGV0_REL=\"../bin/Xwayland.sh\" exec   \"${basedir}/..#{@peer_cmd_prefix}\"   --library-path \"${basedir}/../#{ARCH_LIB}\"   --inhibit-rpath ''   \"${base}.elf\"   \"$@\"
EOF"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/Xwayland", "#{CREW_DEST_PREFIX}/bin/Xwayland.elf"
    system "install -Dm755 Xwayland_sh #{CREW_DEST_PREFIX}/bin/Xwayland"
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/Xwayland", "#{CREW_DEST_PREFIX}/bin/X"
  end
end
