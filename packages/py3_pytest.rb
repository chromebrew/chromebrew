require 'buildsystems/pip'

class Py3_pytest < Pip
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  @_ver = '6.2.5'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_py'
  depends_on 'py3_toml'
  depends_on 'py3_packaging'
  depends_on 'py3_attrs'
  depends_on 'py3_pluggy'
  depends_on 'py3_iniconfig'
  depends_on 'python3' => :build

  no_compile_needed
end
