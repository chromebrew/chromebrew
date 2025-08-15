require 'buildsystems/autotools'

class Xcb_util_cursor < Autotools
  description 'The xcb-util-cursor package provides a module that implements the XCB cursor library. It is a the XCB replacement for libXcursor.'
  homepage 'https://xcb.freedesktop.org/'
  version '0.1.5'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxcb-cursor.git'
  git_hashtag "xcb-util-cursor-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '318d1c11c6e9bc645b9cacc2625e499cd10fd000c41db9b0698d814948133514',
     armv7l: '318d1c11c6e9bc645b9cacc2625e499cd10fd000c41db9b0698d814948133514',
       i686: 'a2beef88e82efe8e8904db22d6298b5da7a2c7687ef2e6e91b2ec7aea95821bd',
     x86_64: 'b9bc0bea5efb9fba07368c41d971b0839e0a87cc8e29d5b135d7151c7dd35afd'
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
