require 'buildsystems/pip'

class Py3_pytest < Pip
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  version '8.3.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b7fa4f12353a410ead3080ceb0cb793a49db3d7a82c6773b961ddbfcdc5961b3',
     armv7l: 'b7fa4f12353a410ead3080ceb0cb793a49db3d7a82c6773b961ddbfcdc5961b3',
       i686: 'ca93a4515d6354566fe5d9c18e375a093d64da218deebd106c6fa8f9cde172ae',
     x86_64: 'ab8baec5f7694de8cdb61f745bfddbffc49f1c48bc9832356d584a1a05ca128a'
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
