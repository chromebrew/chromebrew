require 'package'

class Xorg_lib < Package
  description 'A collection of xorg libraries.'
  homepage ''
  version '0.1'  
  
  is_fake
 
  # new
  depends_on 'libdmx'
  depends_on 'libfs'
  depends_on 'libice'
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
  
end
