require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  @_ver = '2023.07.22'
  version "#{@_ver}-py3.12"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' # L
  no_compile_needed
end
