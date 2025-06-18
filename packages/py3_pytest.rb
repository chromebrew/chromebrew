require 'buildsystems/pip'

class Py3_pytest < Pip
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  version "8.4.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b9c10378695c5c2fef9342e1376376e196bde2534adb1c40eb1cde77d841d96d',
     armv7l: 'b9c10378695c5c2fef9342e1376376e196bde2534adb1c40eb1cde77d841d96d',
       i686: '071278f4a22596c658923e50a5aa513a9a08bacb692136b3a79e62686b0d41fb',
     x86_64: '518c05879a834283f14173713995f51c2541f9e9ba5bf95c2ea2322fc66d5e96'
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
