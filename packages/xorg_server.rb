require 'package'

class Xorg_server < Package
  description 'The Xorg Server is the core of the X Window system.'
  homepage 'https://www.x.org'
  @_ver = '21.1.0'
  version @_ver
  license 'BSD-3, MIT, BSD-4, MIT-with-advertising, ISC and custom'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/xserver.git'
  git_hashtag "xorg-server-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_server/21.1.0_armv7l/xorg_server-21.1.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_server/21.1.0_armv7l/xorg_server-21.1.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_server/21.1.0_x86_64/xorg_server-21.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'caf958b2cadb17e6c3f01437bba3549e7c6711afe307c932a69dbbfbf1476c3e',
     armv7l: 'caf958b2cadb17e6c3f01437bba3549e7c6711afe307c932a69dbbfbf1476c3e',
     x86_64: '7e2a10031216c8769e637ce8b391ca311d5894d3b538e059a57b7bc3d19bb01f'
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
  depends_on 'libxcvt'
  depends_on 'libinput'
  depends_on 'libxdmcp'
  depends_on 'xorg_proto'
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
    system "meson configure #{CREW_MESON_OPTIONS.sub("-Dcpp_args='-O2'", '')} \
              -Db_asneeded=false \
              -Dipv6=true \
              -Dxvfb=true \
              -Dxnest=true \
              -Dxcsecurity=true \
              -Dxorg=true \
              -Dxephyr=true \
              -Dglamor=true \
              -Dudev=true \
              -Dxwin=false \
              -Dsystemd_logind=false \
              -Dint10=auto \
              -Dlog_dir=#{CREW_PREFIX}/var/log \
              build"
    system 'meson configure build'
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    # Get these from xwayland package
    @deletefiles = %W[#{CREW_DEST_PREFIX}/bin/Xwayland #{CREW_DEST_LIB_PREFIX}/xorg/protocol.txt]
    @deletefiles.each do |f|
      FileUtils.rm f if  File.exist?(f)
    end
  end
end
