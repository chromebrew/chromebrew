require 'buildsystems/meson'

class Pixman < Meson
  description 'Pixman is a low-level software library for pixel manipulation, providing features such as image compositing and trapezoid rasterization.'
  homepage 'https://www.pixman.org/'
  version '0.46.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/pixman/pixman.git'
  git_hashtag "pixman-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cc34d57fb02e6ac863a726b3a13c4d80b3ba975bde965b03113da95b5f72ef6a',
     armv7l: 'cc34d57fb02e6ac863a726b3a13c4d80b3ba975bde965b03113da95b5f72ef6a',
       i686: '0afdfa6f061738fc4ca8594857886f7e80bcc1ccbaefcaa11ab22663aee623cd',
     x86_64: 'fa18fdd7bd6c4f8bed2199391b36b6403bee73da220b5730371e13d2f074fed8'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  meson_options '-Dgtk=disabled \
    -Dlibpng=disabled \
    -Dtests=disabled'
end
