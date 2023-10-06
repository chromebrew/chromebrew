require 'buildsystems/pip'

class Py3_importlib_metadata < Pip
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  @_ver = '4.8.1'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_zipp'
  depends_on 'python3' => :build
  no_compile_needed
end
