require 'buildsystems/pip'

class Py3_pytest < Pip
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  version "8.3.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e7a68fcc0a629446f2c5ea9d0479bdc78469f1ae48e2fdc83e7f5e006fffdcdf',
     armv7l: 'e7a68fcc0a629446f2c5ea9d0479bdc78469f1ae48e2fdc83e7f5e006fffdcdf',
       i686: 'c4e7668a899e1bba44a931399386fdf76014981bbd954610a36fa026ff87e355',
     x86_64: '0b610d1b2fcb8fbb0b2cc1d048657f0e6bf51133c53926e1174ac7f5bdcf3507'
  })

  depends_on 'py3_py'
  depends_on 'py3_toml'
  depends_on 'py3_packaging'
  depends_on 'py3_attrs'
  depends_on 'py3_pluggy'
  depends_on 'py3_iniconfig'
  depends_on 'python3' => :build

  no_source_build
end
