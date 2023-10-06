require 'buildsystems/pip'

class Py3_snowballstemmer < Pip
  description 'Snowball stemming library collection for Python'
  homepage 'https://snowballstem.org'
  @_ver = '2.1.0'
  version "#{@_ver}-py3.12"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_pystemmer'
end
