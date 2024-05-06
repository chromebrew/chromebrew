require 'buildsystems/meson'

class Wayland_info < Meson
  description 'Provides wayland-info, a standalone version of the weston-info utility for displaying information about the Wayland protocols supported by a Wayland compositor.'
  homepage 'https://gitlab.freedesktop.org/wayland/wayland-utils'
  version '1.2.0'
  license 'MIT/Expat'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-utils.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e9a0b23b60ad89d46a579661f88e92de74d23f0400b7b89c0873088255c64ba',
     armv7l: '2e9a0b23b60ad89d46a579661f88e92de74d23f0400b7b89c0873088255c64ba',
       i686: '8700677d65661f0c0264a628edf3b7d549973fea47a09ef079c6ccc9f1baacf7',
     x86_64: '3dd8ce56664f9affa0d56bf7c3a36f6d99b6f7a723edbc4694540b4df5624281'
  })

  depends_on 'glibc' # R
  depends_on 'wayland' # R
  depends_on 'wayland_protocols' => :build
end
