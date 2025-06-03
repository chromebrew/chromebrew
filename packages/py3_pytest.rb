require 'buildsystems/pip'

class Py3_pytest < Pip
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  version "8.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8f374caf8cde5529826fc42fa106670ede7e0a017aa936749323cf9b96e6ffd',
     armv7l: 'a8f374caf8cde5529826fc42fa106670ede7e0a017aa936749323cf9b96e6ffd',
       i686: '6feff84c04cecbd3d54a0c4b1fd5110ab8120ed3cc5c41faba316d2b567fc529',
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
