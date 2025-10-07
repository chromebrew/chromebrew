require 'buildsystems/meson'

class Lcms < Meson
  description 'Little CMS intends to be an OPEN SOURCE small-footprint color management engine, with special focus on accuracy and performance.'
  homepage 'https://www.littlecms.com/'
  version '2.17'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/mm2/Little-CMS.git'
  git_hashtag "lcms#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d6e17f41f95a7236eca03b0cbb05a4237aa9f2063c1ba6fd552521ab67db143',
     armv7l: '3d6e17f41f95a7236eca03b0cbb05a4237aa9f2063c1ba6fd552521ab67db143',
     x86_64: '17fa37f57f69985057c28aad710e073c13bbdf847e6efa879cc1f1867c0b877c'
  })

  depends_on 'glibc' # R

  meson_options '-Dfastfloat=true \
                -Dtests=disabled \
                -Dthreaded=true'
end
