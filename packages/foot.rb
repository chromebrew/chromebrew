# Adapted from Arch Linux foot PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=foot

require 'package'

class Foot < Package
  description 'Wayland terminal emulator - fast, lightweight and minimalistic'
  homepage 'https://codeberg.org/dnkl/foot'
  version '1.13.1'
  compatibility 'aarch64, armv7l, x86_64'
  source_url 'https://codeberg.org/dnkl/foot.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/foot/1.13.1_armv7l/foot-1.13.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/foot/1.13.1_armv7l/foot-1.13.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/foot/1.13.1_x86_64/foot-1.13.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a1c2d52499b3c842c1a9c01dfb14024cf435f37d88d53f4bff1a2741cee89e02',
     armv7l: 'a1c2d52499b3c842c1a9c01dfb14024cf435f37d88d53f4bff1a2741cee89e02',
     x86_64: '7586ac28caae7ffd3cb38e700f9455582d7a2a5e47e8e6bd7c78eb2c6a32c0de'
  })

  depends_on 'libxkbcommon'
  depends_on 'wayland'
  depends_on 'pixman'
  depends_on 'fontconfig'
  depends_on 'utf8proc'
  depends_on 'ncurses'
  depends_on 'fcft'
  depends_on 'wayland_protocols' => :build
  depends_on 'tllist' => :build
  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'gcc_lib' # R

  def self.preflight
    abort 'Foot requires glibc > 2.28.' if Gem::Version.new(LIBC_VERSION.to_s) < Gem::Version.new('2.28')
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dterminfo=disabled \
      -Dthemes=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
