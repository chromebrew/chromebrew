require 'buildsystems/pip'

class Py3_pytest < Pip
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  version "9.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5be5ad6e0cecd0fe2a88533d32ee8902eff1fde13ca364e752b36b4360bcdefa',
     armv7l: '5be5ad6e0cecd0fe2a88533d32ee8902eff1fde13ca364e752b36b4360bcdefa',
       i686: 'bd824e62b0848d3a8d0b2e3f525eb6ad5d5c6299a769c84689dc46a2b6df2cf2',
     x86_64: 'ed949688c36d90c5c89033eb7c72c7a44804b73b92fc0dde4358381677041563'
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
