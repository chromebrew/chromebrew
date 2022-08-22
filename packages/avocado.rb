require 'package'

class Avocado < Package
  description 'A dummy package for avocado_framework.'
  homepage 'https://avocado-framework.github.io/'
  @_ver = '94.0'
  version @_ver
  license 'GPL-2 and GPL-2+'
  compatibility 'all'
  is_fake

  depends_on 'avocado_framework'
end
