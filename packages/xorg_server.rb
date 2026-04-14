require 'buildsystems/meson'

class Xorg_server < Meson
  description 'The Xorg Server is the core of the X Window system.'
  homepage 'https://gitlab.freedesktop.org/xorg/xserver'
  version '21.1.22'
  license 'BSD-3, MIT, BSD-4, MIT-with-advertising, ISC and custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/xserver.git'
  git_hashtag "xorg-server-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4047c3058556ea480a37ee2e4b54f73bc2529b520c54a45f0dbfb58ad9caf0cd',
     armv7l: '4047c3058556ea480a37ee2e4b54f73bc2529b520c54a45f0dbfb58ad9caf0cd',
     x86_64: '24c4d99d10620c48dd90a080a1da75d0a24fce920934f56d24891fa5122c2e2e'
  })

  depends_on 'dbus' => :executable
  depends_on 'eudev' => :library
  depends_on 'font_util' => :build
  depends_on 'gcc_lib' => :build
  depends_on 'glibc' => :library
  depends_on 'graphite' => :build
  depends_on 'libbsd' => :library
  depends_on 'libdrm' => :library
  depends_on 'libepoxy' => :library
  depends_on 'libfontenc' => :build
  depends_on 'libglvnd' => :library
  depends_on 'libinput' => :build
  depends_on 'libmd' => :executable
  depends_on 'libminigbm' => :library
  depends_on 'libpciaccess' => :executable
  depends_on 'libtirpc' => :executable
  depends_on 'libudev_stub' => :library
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
  depends_on 'vdev' => :library
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
