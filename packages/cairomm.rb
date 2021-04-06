require 'package'

class Cairomm < Package
  description 'The Cairomm package provides a C++ interface to Cairo.'
  homepage 'https://www.cairographics.org/'
  version '1.0'
  license 'LGPL-2+'
  compatibility 'all'

  is_fake

  depends_on 'cairomm_1_0'
  depends_on 'cairomm_1_16'
end
