require 'buildsystems/pip'

class Py3_secretstorage < Pip
  description 'Python bindings to Freedesktop.org Secret Service API'
  homepage 'https://secretstorage.readthedocs.io/'
  @_ver = '3.3.1'
  version "#{@_ver}-py3.12"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_jeepney'
  depends_on 'py3_cryptography'
  depends_on 'python3' => :build
  no_compile_needed
end
