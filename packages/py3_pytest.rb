require 'buildsystems/pip'

class Py3_pytest < Pip
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  version "9.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a261ea049d577f0129670a387aab6918e908fd156e1ab643cc9ed033e4b41b22',
     armv7l: 'a261ea049d577f0129670a387aab6918e908fd156e1ab643cc9ed033e4b41b22',
       i686: '975f3ae22f90ccb5a47222c5f59acac948e32c64cfb9016f3e8604a01f882cfc',
     x86_64: '348a86baeaf1d55ac8a98550ee815a20252ad1c0520c254b7f88d1339adf87d6'
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
