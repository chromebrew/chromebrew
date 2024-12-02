require 'buildsystems/pip'

class Py3_pytest < Pip
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  version "8.3.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea3adc1801b1484856f5ba56b0d80e74c3f6b62724e19b13c7ff29aa7a9167ce',
     armv7l: 'ea3adc1801b1484856f5ba56b0d80e74c3f6b62724e19b13c7ff29aa7a9167ce',
       i686: '7e08ed9072f24571eccc5465ccb1f6237964542c5e3816be5a6fc4db0e7c8ee4',
     x86_64: '5f355f2425bfba9dc19684562e23a46d96a7db1ca6391a0bf9180b163eee4d92'
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
