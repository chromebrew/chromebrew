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
    aarch64: '51c1b43de8125c96d80e74e147e45ade10312f3ccefbb9a4f81f76a1db4e7877',
     armv7l: '51c1b43de8125c96d80e74e147e45ade10312f3ccefbb9a4f81f76a1db4e7877',
     x86_64: 'c4b408ff17ed182879a50321103b7b06d35a19029c9a5c86ccd044597158f900'
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
