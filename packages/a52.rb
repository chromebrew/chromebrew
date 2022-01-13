require 'package'

class A52 < Package
  description 'Legacy compatibility package for liba52'
  homepage 'http://liba52.sourceforge.net/'
  @_ver = '0.7.4-1'
  version @_ver
  license 'public-domain'
  compatibility 'all'

  is_fake

  depends_on 'liba52'
end
