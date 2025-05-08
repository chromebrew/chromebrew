require 'buildsystems/meson'

class Libxcomposite < Meson
  description 'X.org X Composite Library'
  homepage 'https://www.x.org/wiki/'
  version '0.4.6-f796f0a'
  license 'X11'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxcomposite.git'
  git_hashtag "f796f0a862849765ac5b6b5e861ea548b421b8f0"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50e1b0cb36c409a0fd6ef47b41e4ebc98458eaf011d02960517bdc1cc7dc0414',
     armv7l: '50e1b0cb36c409a0fd6ef47b41e4ebc98458eaf011d02960517bdc1cc7dc0414',
     x86_64: '73bbe30ceb97b42ec1c7ab78c4b0df8df1f2a2900016b2ebc7206160988a8851'
  })

  depends_on 'libxfixes' => :build
  depends_on 'libxext' => :build
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R

end
