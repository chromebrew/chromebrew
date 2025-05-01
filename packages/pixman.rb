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
    aarch64: '96328061e6337e4395ea4e178cc9fe201ea7713a7ca47dcc26e425c00e878f59',
     armv7l: '96328061e6337e4395ea4e178cc9fe201ea7713a7ca47dcc26e425c00e878f59',
       i686: '0afdfa6f061738fc4ca8594857886f7e80bcc1ccbaefcaa11ab22663aee623cd',
     x86_64: '649b3673ed250ed5ef978fb795d15136f9975c8b9b961bf5b9606e3931c61f63'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  meson_options '-Dgtk=disabled \
    -Dlibpng=disabled \
    -Dtests=disabled'
end
