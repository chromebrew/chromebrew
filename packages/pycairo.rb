require 'package'

class Pycairo < Package
  description 'Dummy package for py3_pycairo.'
  homepage 'https://cairographics.org/pycairo/'
  version '1'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'all'
  is_fake

  depends_on 'py3_pycairo'
end
