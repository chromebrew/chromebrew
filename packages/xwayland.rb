require 'package'

class Xwayland < Package
  description 'X server configured to work with weston or sommelier'
  homepage 'https://x.org'
  @_ver = '22.1.0'
  version @_ver
  license 'MIT-with-advertising, ISC, BSD-3, BSD and custom'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/xserver.git'
  git_hashtag "xwayland-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xwayland/22.1.0_armv7l/xwayland-22.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xwayland/22.1.0_armv7l/xwayland-22.1.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xwayland/22.1.0_i686/xwayland-22.1.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xwayland/22.1.0_x86_64/xwayland-22.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'aa65bcfdb34edc61b04db0c5970f579a11621b597788c801695fb32bcd2b1a6c',
     armv7l: 'aa65bcfdb34edc61b04db0c5970f579a11621b597788c801695fb32bcd2b1a6c',
       i686: '4cc31306f6cef4254394ed7cacbd5375880660b27976e347377a0b08342b7efc',
     x86_64: '80dc3f551c7c171f0b654c64437e298f84832cc4b170895c1bebfff376425157'
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
  depends_on 'libunwind' # Runtime dependency for sommelier
  depends_on 'libxau' # R
  depends_on 'libxcvt' => :build
  depends_on 'libxdmcp' # R
  depends_on 'libxfont2' # R
  depends_on 'libxfont' # R
  depends_on 'libxkbcommon'
  depends_on 'libxkbfile' # R
  depends_on 'libxshmfence' # R
  depends_on 'libxtrans'
  depends_on 'mesa' # R
  depends_on 'pixman' # R
  depends_on 'rendercheck' # R
  depends_on 'wayland' # R
  depends_on 'xkbcomp'
  depends_on 'xorg_lib'

  case ARCH
  when 'armv7l', 'aarch64'
    PEER_CMD_PREFIX = '/lib/ld-linux-armhf.so.3'.freeze
  when 'i686'
    PEER_CMD_PREFIX = '/lib/ld-linux.so.2'.freeze
  when 'x86_64'
    PEER_CMD_PREFIX = '/lib64/ld-linux-x86-64.so.2'.freeze
  end

  def self.build
    system 'meson setup build'
    system "meson configure #{CREW_MESON_OPTIONS.sub("-Dcpp_args='-O2'", '')} \
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
