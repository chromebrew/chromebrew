require 'buildsystems/meson'

class Libxdamage < Meson
  description 'library for the X window system'
  homepage 'https://x.org/wiki/'
  version '1.1.6-1319ae5'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxdamage.git'
  git_hashtag '1319ae5cfbde5b75e23383baa5e00cc23513448c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1acd0ec73124faf374844894ebbaa792e985272284c5ff544c93499c3b6d8e2f',
     armv7l: '1acd0ec73124faf374844894ebbaa792e985272284c5ff544c93499c3b6d8e2f',
     x86_64: '122712b7c3630e9d849fa134d94201437da15ff1cda107d9932cc3a39d08d6c4'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxfixes' # R
end
