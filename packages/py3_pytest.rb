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
       i686: '182ed975e3d09d299559b33bcabca68586e83dbe6f71a963795599283690b0e5',
     x86_64: '748f87e1e5797148146ee578eec9900415e080d6e64a6cbf758a3160b8a8faf0'
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
