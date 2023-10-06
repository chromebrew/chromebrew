require 'buildsystems/pip'

class Py3_snowballstemmer < Pip
  description 'Snowball stemming library collection for Python'
  homepage 'https://snowballstem.org'
  @_ver = '2.1.0'
  version "#{@_ver}-py3.12"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  source_sha256 'e997baa4f2e9139951b6f4c631bad912dfd3c792467e2f03d7239464af90e914'

  binary_url({})
  binary_sha256({})

  depends_on 'py3_pystemmer'
end
