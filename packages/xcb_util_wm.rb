require 'buildsystems/autotools'

class Xcb_util_wm < Autotools
  description 'The xcb-util-wm package contains libraries which provide client and window-manager helpers for EWMH and ICCCM.'
  homepage 'https://xcb.freedesktop.org/'
  version '0.4.2'
  compatibility 'all'
  license 'MIT-with-advertising'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxcb-wm.git'
  git_hashtag "xcb-util-wm-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cd3f107f18b447d79b5b93d7ad040ff1fb9d111266749c2a95d7e01e533143fb',
     armv7l: 'cd3f107f18b447d79b5b93d7ad040ff1fb9d111266749c2a95d7e01e533143fb',
       i686: '5eeaccb04005b786d69e21f1edab01616e1875e3e617a9e7567da2e0d509db21',
     x86_64: '927bb5dc470f70d8fbe5d2f690470ad15e13458ab8254c3e7e15df2c40385bf2'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxau' # R
end
