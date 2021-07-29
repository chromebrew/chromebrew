require 'package'

class Six < Package
  description 'Dummy package for py3_six'
  homepage 'https://six.readthedocs.io/'
  version '1'
  license 'MIT'
  compatibility 'all'

  is_fake

  depends_on 'py3_six'
end
