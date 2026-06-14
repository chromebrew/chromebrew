require 'buildsystems/pip'

class Py3_pytest < Pip
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  version "9.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '422f3460e32d4b383596a7cca9682e0849e97674e7905458a709a098f300dbb4',
     armv7l: '422f3460e32d4b383596a7cca9682e0849e97674e7905458a709a098f300dbb4',
       i686: '222fc21fdccc6ce15e4b6cd13b6a6d6de06bf0fe1b6ac39237b26be1ca65e0ad',
     x86_64: '9ee379e4ebd26896f047f12202306036fc4be4e1799d7d686f161eed12bcca53'
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
