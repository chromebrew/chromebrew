require 'buildsystems/pip'

class Py3_pytest < Pip
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  version "9.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a955175b3cfa4f0314bcadba3f631663efabf97e34346f101cce2478c2a24a24',
     armv7l: 'a955175b3cfa4f0314bcadba3f631663efabf97e34346f101cce2478c2a24a24',
       i686: 'ce30cd1b0ff5c2b42ac0b979541afd5a734ce9e5efc0679f61cf2dbb74e8507a',
     x86_64: '1863613b56a0e0ca1d5f852a3f9d3f47bc7cbc82112de00c56660c53ecc97150'
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
