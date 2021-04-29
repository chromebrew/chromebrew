# Do not use this package as a dependency for other packages.
require 'package'

class Setuptools < Package
  description 'A package that installs setuptools for all python versions.'
  homepage 'https://pypi.org/project/setuptools/'
  version '1.0'
  license 'MIT'
  compatibility 'all'

  is_fake

  depends_on 'py3_setuptools'
  depends_on 'py2_setuptools'

end
