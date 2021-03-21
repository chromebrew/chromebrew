require 'package'

class Xorg_lib < Package
  description 'A collection of xorg libraries.'
  homepage ''
  version '0.1-0'
  license '' # is_fake
  compatibility 'all'

  is_fake

  depends_on 'libxtrans'
  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libfontenc'
  depends_on 'libxinerama'
  depends_on 'libxdamage'
  depends_on 'libxtst'
  depends_on 'libpciaccess'
  depends_on 'libxkbfile'
  depends_on 'libxshmfence'
  depends_on 'libxi'
  depends_on 'libxcursor'
  depends_on 'libxrender'
  depends_on 'libxfixes'

  # new
  depends_on 'libdmx'
  depends_on 'libfs'
  depends_on 'libice'
  depends_on 'libsm'
  depends_on 'libxaw'
  depends_on 'libxfont2'
  depends_on 'libxft'
  depends_on 'libxmu'
  depends_on 'libxpm'
  depends_on 'libxrandr'
  depends_on 'libxres'
  depends_on 'libxt'
  depends_on 'libxv'
  depends_on 'libxvmc'
  depends_on 'libxxf86dga'
  depends_on 'libxxf86vm'
  depends_on 'libxcomposite'
  depends_on 'libxss'
end
