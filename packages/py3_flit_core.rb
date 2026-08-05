require 'buildsystems/pip'

class Py3_flit_core < Pip
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  version "4.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a1777697d850a463374f75711615e3bfdf8cf5b2020d100c5e4319fba5c94316',
     armv7l: 'a1777697d850a463374f75711615e3bfdf8cf5b2020d100c5e4319fba5c94316',
       i686: '9e4ddcb6b8b394d74c239a2a110783325ed627de54e4d9d40cdc7fe2c0740ac3',
     x86_64: '822b32fcfbcb1367f000123920ed28b1cb66e0e42995acdb6607292e3e2f7f79'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
