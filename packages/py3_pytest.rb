require 'buildsystems/pip'

class Py3_pytest < Pip
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  version "9.0.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6cf34ae6c0fefd0bcb663955df8dce1f46f71e4ce3e69d0ee2bec2b3ef306c6',
     armv7l: 'a6cf34ae6c0fefd0bcb663955df8dce1f46f71e4ce3e69d0ee2bec2b3ef306c6',
       i686: '15b68630c2f1047b44afc90878376630d741e1e31b8bf2f59bad11b62cd64490',
     x86_64: 'f1ed4fdb0e4474deffaf20f3b5689ff9cb7f18670e2b9f032e001337ca1185e9'
  })

  depends_on 'py3_attrs'
  depends_on 'py3_iniconfig'
  depends_on 'py3_packaging'
  depends_on 'py3_pluggy'
  depends_on 'py3_py'
  depends_on 'py3_toml'
  depends_on 'python3' => :logical

  no_source_build
end
