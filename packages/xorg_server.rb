require 'buildsystems/meson'

class Xorg_server < Meson
  description 'The Xorg Server is the core of the X Window system.'
  homepage 'https://gitlab.freedesktop.org/xorg/xserver'
  version '21.1.24'
  license 'BSD-3, MIT, BSD-4, MIT-with-advertising, ISC and custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/xserver.git'
  git_hashtag "xorg-server-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db22a89481d542c0c4d0467e13153c13215f2f3306afbbb9bc2af9562e83150b',
     armv7l: 'db22a89481d542c0c4d0467e13153c13215f2f3306afbbb9bc2af9562e83150b',
     x86_64: '799428b5318a930cc5c870c783640484dc88e1292a3cdf4a8a0afb7534976840'
  })

  depends_on 'dbus' => :executable
  depends_on 'eudev' => :library
  depends_on 'font_util' => :build
  depends_on 'gcc_lib' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphite' => :build
  depends_on 'libbsd' => :library
  depends_on 'libdrm' => :library
  depends_on 'libepoxy' => :library
  depends_on 'libfontenc' => :build
  depends_on 'libglvnd' => :library
  depends_on 'libinput' => :build
  depends_on 'libmd' => :executable
  depends_on 'libpciaccess' => :executable
  depends_on 'libtirpc' => :executable
  depends_on 'libunwind' => :build
  depends_on 'libx11' => :executable
  depends_on 'libxau' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'libxcvt' => :executable
  depends_on 'libxdmcp' => :library
  depends_on 'libxext' => :executable
  depends_on 'libxfont2' => :library
  depends_on 'libxkbcommon' => :build
  depends_on 'libxkbfile' => :library
  depends_on 'libxshmfence' => :executable
  depends_on 'libxtrans' => :build
  depends_on 'lzma' => :build
  depends_on 'mesa' => :library
  depends_on 'pixman' => :library
  depends_on 'xcb_util' => :executable
  depends_on 'xcb_util_cursor' => :build
  depends_on 'xcb_util_image' => :executable
  depends_on 'xcb_util_keysyms' => :executable
  depends_on 'xcb_util_renderutil' => :executable
  depends_on 'xcb_util_wm' => :executable
  depends_on 'xcb_util_xrm' => :build
  depends_on 'xkbcomp' => :build
  depends_on 'xorg_proto' => :build

  meson_options "-Db_asneeded=false \
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
              -Dlog_dir=#{CREW_PREFIX}/var/log"

  meson_install_extras do
    # Get these from xwayland package
    @deletefiles = %W[#{CREW_DEST_PREFIX}/bin/Xwayland #{CREW_DEST_LIB_PREFIX}/xorg/protocol.txt]
    @deletefiles.each do |f|
      FileUtils.rm_f f
    end
  end
end
