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
    aarch64: '83c65ce4bb4fa84add429f64536becf58526919fb07e43edc69d378caafe15ab',
     armv7l: '83c65ce4bb4fa84add429f64536becf58526919fb07e43edc69d378caafe15ab',
       i686: 'a7d5a02c3cc7014e3b979d8a73a20f6e30dacb836248d2477608cf19ac1f6e8f',
     x86_64: '050857217946061e8a41599e378f7cda65196b93b8e7af312519b3735f52cf2d'
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
