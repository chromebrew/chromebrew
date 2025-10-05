require 'buildsystems/meson'

class Libxrender < Meson
  description 'X Rendering Extension client library.'
  homepage 'https://www.x.org/wiki/'
  version '0.9.12-01c4bb5'
  license 'HPND-sell-variant'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxrender.git'
  git_hashtag '01c4bb5b30bbb09921ca4042da369a60a73faefa'
  # git_hashtag "libXrender-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56c5112fc27dbbc14d048dd531c8e83106700fbca70b85ea830d84eb58c756d3',
     armv7l: '56c5112fc27dbbc14d048dd531c8e83106700fbca70b85ea830d84eb58c756d3',
     x86_64: '5969b67de7f0529b6f3a7f663ae769cf609c607e9d7c30b6ee5507806e02e17e'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
end
