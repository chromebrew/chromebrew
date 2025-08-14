require 'buildsystems/autotools'

class Libxcb < Autotools
  description 'library for the X window system'
  homepage 'https://x.org/wiki/'
  version '1.17.0'
  license 'X11'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxcb.git'
  git_hashtag "libxcb-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd7177440c950f3cb59e7985ac3d9762619b4bd516f85e70c6ba669c2081c5dc8',
     armv7l: 'd7177440c950f3cb59e7985ac3d9762619b4bd516f85e70c6ba669c2081c5dc8',
       i686: 'b6b9df40312c3619f569a0d7e1eed34e83d455cae73bccf557ba1834e6e07b2a',
     x86_64: '820893f02d0bd35228cce57f2e222db0bb1beff6a1b7adc1f95ffae046a03c9d'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxau'
  depends_on 'libxdmcp' # R
  depends_on 'pthread_stubs'
  depends_on 'xcb_proto'

  autotools_configure_options '--enable-dri3 \
        --disable-xevie \
        --disable-devel-docs'
end
