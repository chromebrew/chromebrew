require 'package'

class Libgcc_s1 < Package
  description 'GCC support library'
  homepage 'https://www.gnu.org/software/gcc/'
  version '11.1.0-1'
  license 'GPL-3, LGPL-3, libgcc, FDL-1.2'
  compatibility 'all'

  depends_on 'gcc11'
  
  is_fake
  
end
