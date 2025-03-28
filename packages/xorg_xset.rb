# Adapted from Arch Linux xorg-xset PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/xorg-xset/trunk/PKGBUILD

require 'package'

class Xorg_xset < Package
  description 'User preference utility for X'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.2.5'
  license 'X11'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xset.git'
  git_hashtag "xset-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '263227acbc9ac98ea273553ef221ae516375f5e410ef87bd435862ce735faf3f',
     armv7l: '263227acbc9ac98ea273553ef221ae516375f5e410ef87bd435862ce735faf3f',
     x86_64: '52dfdb502a8a52a570e0e54a2a8fe6e2adba0366cdba14474eda26c3a98b626a'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxmu' # R
  depends_on 'xorg_macros' => :build

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_CONFIGURE_OPTIONS} \
    --without-fontcache \
    --without-xf86misc"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
