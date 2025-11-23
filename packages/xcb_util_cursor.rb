require 'buildsystems/autotools'

class Xcb_util_cursor < Autotools
  description 'The xcb-util-cursor package provides a module that implements the XCB cursor library. It is a the XCB replacement for libXcursor.'
  homepage 'https://xcb.freedesktop.org/'
  version '0.1.6'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxcb-cursor.git'
  git_hashtag "xcb-util-cursor-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '96ee4775b9c934aeb6ca69dd011aa30f522e0cc3a9b5e9316f00438342193e98',
     armv7l: '96ee4775b9c934aeb6ca69dd011aa30f522e0cc3a9b5e9316f00438342193e98',
       i686: '64f8829b6f2b5619f85208748bbcb4dcc7f85d6263b2e0e0622f8149bbd2e771',
     x86_64: '1985001323af5a8704adf8514cac9f61bf957756cb940e907e3005fa885a1eb6'
  })

  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'libbsd' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'm4'
  depends_on 'xcb_util'
  depends_on 'xcb_util_image'
  depends_on 'xcb_util_renderutil'
end
