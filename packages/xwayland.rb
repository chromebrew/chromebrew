require 'buildsystems/meson'

class Xwayland < Meson
  description 'X server configured to work with weston or sommelier'
  homepage 'https://x.org/wiki/'
  version '24.1.13'
  license 'MIT-with-advertising, ISC, BSD-3, BSD and custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/xserver.git'
  git_hashtag "xwayland-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ee21bf10281802579aea90df7a4e6d973594bc2529f3548532f4bb9a226ccf06',
     armv7l: 'ee21bf10281802579aea90df7a4e6d973594bc2529f3548532f4bb9a226ccf06',
     x86_64: 'f5cea055c84f358686f997368454968919ef9459b0bae63975cd3dd6fe8e29d9'
  })

  no_env_options
  no_shrink

  depends_on 'dbus' => :build
  depends_on 'eudev' => :build
  depends_on 'font_util' => :build
  depends_on 'gcc_lib' => :build
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'graphite' => :build
  depends_on 'libbsd' => :executable
  depends_on 'libdecor' => :executable
  depends_on 'libdrm' => :executable
  depends_on 'libepoxy' => :executable
  depends_on 'libfontenc' => :build
  depends_on 'libglvnd' => :executable
  depends_on 'libmd' => :executable
  depends_on 'libtirpc' => :executable
  depends_on 'libunwind' => :logical # Runtime dependency for sommelier
  depends_on 'libxau' => :executable
  depends_on 'libxcvt' => :executable
  depends_on 'libxdmcp' => :executable
  depends_on 'libxfont2' => :executable
  depends_on 'libxkbcommon' => :build
  depends_on 'libxkbfile' => :executable
  depends_on 'libxshmfence' => :executable
  depends_on 'libxtrans' => :build
  depends_on 'mesa' => :executable
  depends_on 'pixman' => :executable
  depends_on 'rendercheck' => :build
  depends_on 'wayland' => :executable
  depends_on 'xkbcomp' => :build
  depends_on 'xmlto' => :build
  depends_on 'xorg_proto' => :build

  meson_options '-Db_asneeded=false \
              -Dipv6=true \
              -Dxvfb=true \
              -Dxcsecurity=true \
              -Dglamor=true'

  meson_install_extras do
    # Get these from xorg_server package
    @deletefiles = %W[#{CREW_DEST_PREFIX}/bin/X #{CREW_DEST_MAN_PREFIX}/man1/Xserver.1]
    @deletefiles.each do |f|
      FileUtils.rm_f f
    end
  end
end
