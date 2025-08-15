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
    aarch64: '860d613c9e5ddb61f6cc91f1a12a3c31733e7c489de988b904708ae557e092d5',
     armv7l: '860d613c9e5ddb61f6cc91f1a12a3c31733e7c489de988b904708ae557e092d5',
       i686: '5eeaccb04005b786d69e21f1edab01616e1875e3e617a9e7567da2e0d509db21',
     x86_64: '927bb5dc470f70d8fbe5d2f690470ad15e13458ab8254c3e7e15df2c40385bf2'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'm4'

end
