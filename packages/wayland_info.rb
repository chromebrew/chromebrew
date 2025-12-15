require 'buildsystems/meson'

class Wayland_info < Meson
  description 'Provides wayland-info, a standalone version of the weston-info utility for displaying information about the Wayland protocols supported by a Wayland compositor.'
  homepage 'https://gitlab.freedesktop.org/wayland/wayland-utils'
  version '1.3.0'
  license 'MIT/Expat'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-utils.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d8c5448c8090204fdd9f692db4470f54eaf52923c4f3603f45a7a8c53ea823c',
     armv7l: '6d8c5448c8090204fdd9f692db4470f54eaf52923c4f3603f45a7a8c53ea823c',
       i686: '9bd71b9fd542d530153b77cb162092e1e4d50096e7e53078af770ee1aef49ced',
     x86_64: 'b5835c23e9940ab4b89c291e2ab7130f2e86eee848ffc2de764ff37c394d3968'
  })

  depends_on 'glibc' # R
  depends_on 'wayland' # R
  depends_on 'wayland_protocols' => :build
end
