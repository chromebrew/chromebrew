require 'buildsystems/meson'

class Pixman < Meson
  description 'Pixman is a low-level software library for pixel manipulation, providing features such as image compositing and trapezoid rasterization.'
  homepage 'https://www.pixman.org/'
  version '0.46.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/pixman/pixman.git'
  git_hashtag "pixman-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '07fb41f46d8780e3c641d10336e29ddee4c03c49dc330aeb4df3cfd7d6e3d75f',
     armv7l: '07fb41f46d8780e3c641d10336e29ddee4c03c49dc330aeb4df3cfd7d6e3d75f',
       i686: '61d75628797970d497f5daced8928b89792c7fa13feb7d3ece3b004f6608c92d',
     x86_64: '04b430b613c91e18e697c6baa0a1844881dad9b74a7cb88606591582ba5e42c9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  meson_options '-Dgtk=disabled \
    -Dlibpng=disabled \
    -Dtests=disabled'
end
