require 'buildsystems/meson'

class Libxrender < Meson
  description 'X Rendering Extension client library.'
  homepage 'https://www.x.org/wiki/'
  version '0.9.11-01c4bb5'
  license 'HPND-sell-variant'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxrender.git'
  git_hashtag '01c4bb5b30bbb09921ca4042da369a60a73faefa'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d5def75a204202215bb57e90f922a84dc095bcf5e305d28fdc4f36504b54bc1',
     armv7l: '1d5def75a204202215bb57e90f922a84dc095bcf5e305d28fdc4f36504b54bc1',
     x86_64: '9f8c1d060da336e3d70a3aca14a12c7ceba34a0e37467dd1a616a7cede3d3b46'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
end
