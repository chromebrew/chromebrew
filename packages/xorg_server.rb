require 'package'

class Xorg_server < Package
  description 'The Xorg Server is the core of the X Window system.'
  homepage 'https://www.x.org'
  @_ver = '1.20.11'
  version @_ver
  license 'BSD-3, MIT, BSD-4, MIT-with-advertising, ISC and custom'
  compatibility 'all'
  source_url "https://gitlab.freedesktop.org/xorg/xserver/-/archive/xorg-server-#{@_ver}/xserver-xorg-server-#{@_ver}.tar.bz2"
  source_sha256 'c03ef3c2dc44e75bf8caf942135a5aba3638822edb835bd05d2eaf428531a6a2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_server/1.20.11_armv7l/xorg_server-1.20.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_server/1.20.11_armv7l/xorg_server-1.20.11-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_server/1.20.11_i686/xorg_server-1.20.11-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_server/1.20.11_x86_64/xorg_server-1.20.11-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '27cb4df4959f2d8e4d379d66daead6fb286bafada5f493d0049fb28227160493',
     armv7l: '27cb4df4959f2d8e4d379d66daead6fb286bafada5f493d0049fb28227160493',
       i686: 'f5285506842220eb0690b88a6be7dc921d6be4e51b7db5e25c5d65f75cd1f173',
     x86_64: '732dd1586499edd926531f56e83f1bf38bdc743203a0041ff2fb1b78e3b2738c'
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
    system "meson configure #{CREW_MESON_OPTIONS} \
              -Db_asneeded=false \
              -Dipv6=true \
              -Dxvfb=true \
              -Dxnest=true \
              -Dxcsecurity=true \
              -Dxorg=true \
              -Dxephyr=true \
              -Dxwayland=false \
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
