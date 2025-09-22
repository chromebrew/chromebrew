require 'buildsystems/pip'

class Py3_pytest < Pip
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  version "8.4.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '672097f5f199a03b85ae52cb39d75c58c391c2f6382856eeb4290d8dbe0c54df',
     armv7l: '672097f5f199a03b85ae52cb39d75c58c391c2f6382856eeb4290d8dbe0c54df',
       i686: 'f72aab44fac4a7c18ab83521c243993e74ee2255aed4e7da9b7ad568dcbb6f32',
     x86_64: '425939db1f1948f6ceb99eacae9c92be603191b8cd64b7e8bbbd869bd7fc4b2a'
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
