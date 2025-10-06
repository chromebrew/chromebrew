require 'buildsystems/meson'

class Xwayland < Meson
  description 'X server configured to work with weston or sommelier'
  homepage 'https://x.org/wiki/'
  version '24.1.8-1'
  license 'MIT-with-advertising, ISC, BSD-3, BSD and custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/xserver.git'
  git_hashtag "xwayland-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7cdad4692f031d20a199c160d1d1ab2912121566d8695dfee5380d7cc515a3b3',
     armv7l: '7cdad4692f031d20a199c160d1d1ab2912121566d8695dfee5380d7cc515a3b3',
     x86_64: '93f9cafe2df34f61843c0a573b049c3357a094c80b7c0d72fa3adaf1112977af'
  })

  no_env_options
  no_shrink

  depends_on 'dbus' => :build
  depends_on 'eudev' => :build
  depends_on 'font_util' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  # depends_on 'glproto' => :build Conflict with xorg_proto
  depends_on 'graphite' => :build
  depends_on 'libbsd' # R
  depends_on 'libdecor' # R
  depends_on 'libdrm' # R
  depends_on 'libepoxy' # R
  depends_on 'libfontenc' => :build
  depends_on 'libglvnd' # R
  depends_on 'libmd' # R
  depends_on 'libtirpc' # R
  depends_on 'libunwind' # Runtime dependency for sommelier
  depends_on 'libxau' # R
  depends_on 'libxcvt' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxfont2' # R
  depends_on 'libxkbcommon' => :build
  depends_on 'libxkbfile' # R
  depends_on 'libxshmfence' # R
  depends_on 'libxtrans' => :build
  depends_on 'mesa' # R
  depends_on 'pixman' # R
  depends_on 'rendercheck' # R
  depends_on 'wayland' # R
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
