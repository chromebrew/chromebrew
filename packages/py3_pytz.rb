require 'buildsystems/pip'

class Py3_pytz < Pip
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  @_ver = '2023.3.post1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
