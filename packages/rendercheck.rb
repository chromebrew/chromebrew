require 'buildsystems/meson'

class Rendercheck < Meson
  description 'rendercheck is a program to test a Render extension implementation against separate calculations of expected output.'
  homepage 'https://www.x.org/wiki/'
  version '1.6'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/test/rendercheck.git'
  git_hashtag "rendercheck-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c32a8a4206836185ddd2700c5f648fbbb098a08e99580b6e6574398cf40b96c5',
     armv7l: 'c32a8a4206836185ddd2700c5f648fbbb098a08e99580b6e6574398cf40b96c5',
     x86_64: 'c9ab0d3cd5e40aa84ab0308ca9b6d42685d3ae577baa7f363731dc08c9d008a7'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxrender' # R
end
