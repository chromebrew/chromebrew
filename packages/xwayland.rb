require 'package'

class Xwayland < Package
  description 'X server configured to work with weston or sommelier'
  homepage 'https://x.org'
  @_ver = '22.1.5'
  version @_ver
  license 'MIT-with-advertising, ISC, BSD-3, BSD and custom'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/xserver.git'
  git_hashtag "xwayland-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xwayland/22.1.3_armv7l/xwayland-22.1.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xwayland/22.1.3_armv7l/xwayland-22.1.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xwayland/22.1.3_i686/xwayland-22.1.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xwayland/22.1.3_x86_64/xwayland-22.1.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '88d2b2a530e5c41a3c5e94c247ff189a472d4ca998fe78f3beeafe256f4f5e17',
     armv7l: '88d2b2a530e5c41a3c5e94c247ff189a472d4ca998fe78f3beeafe256f4f5e17',
       i686: '78f652ff3a1dcec7e2bf6a07ef2693e0a98c554446e935a669becb16da652cec',
     x86_64: 'c11d28840e9f7d4cb74ef568c356fc38499ca95921f439d588140d727d341bee'
  })

  no_env_options

  depends_on 'dbus' => :build
  depends_on 'eudev' => :build
  depends_on 'font_util' => :build
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glproto'
  depends_on 'graphite'
  depends_on 'libbsd' # R
  depends_on 'libdrm' # R
  depends_on 'libepoxy' # R
  depends_on 'libmd' # R
  depends_on 'libtirpc' # R
  depends_on 'libunwind' # Runtime dependency for sommelier
  depends_on 'libxau' # R
  depends_on 'libxcvt' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxfont2' # R
  depends_on 'libxfont' # R
  depends_on 'libxkbcommon'
  depends_on 'libxkbfile' # R
  depends_on 'libxshmfence' # R
  depends_on 'libxtrans' => :build
  depends_on 'mesa' # R
  depends_on 'pixman' # R
  depends_on 'rendercheck' # R
  depends_on 'wayland' # R
  depends_on 'xkbcomp' => :build

  def self.build
    system 'meson setup build'
    system "meson configure #{CREW_MESON_OPTIONS.sub(/(-Dcpp_args='*)(.*)(')/, '')} \
              -Db_asneeded=false \
              -Dipv6=true \
              -Dxvfb=true \
              -Dxcsecurity=true \
              -Dglamor=true \
              build"
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    # Get these from xorg_server package
    @deletefiles = %W[#{CREW_DEST_PREFIX}/bin/X #{CREW_DEST_MAN_PREFIX}/man1/Xserver.1]
    @deletefiles.each do |f|
      FileUtils.rm_f f
    end
  end
end
