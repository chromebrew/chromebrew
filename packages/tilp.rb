require 'package'

class Tilp < Package
  description 'TiLP is a linking program for Texas Instruments\' graphing calculators.'
  homepage 'http://lpg.ticalc.org/prj_tilp/'
  version '1.18'
  compatibility 'all'

  is_fake

  depends_on 'tilp2'

end
