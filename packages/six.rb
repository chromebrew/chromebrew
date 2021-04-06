require 'package'

class Six < Package
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://six.readthedocs.io/'
  version '1.15.0'
  license 'MIT'
  compatibility 'all'

  is_fake

  depends_on 'py2_six'
  depends_on 'py3_six'
end
