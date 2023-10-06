require 'buildsystems/pip'

class Py3_pystemmer < Pip
  description 'Snowball stemming algorithms, for information retrieval'
  homepage 'http://snowball.tartarus.org'
  @_ver = '2.0.1'
  version "#{@_ver}-py3.12"
  license 'BSD MIT'
  compatibility 'all'
  source_url 'SKIP'
  source_sha256 '9b81c35302f1d2a5ad9465b85986db246990db93d97d3e8f129269ed7102788e'

  binary_url({})
  binary_sha256({})

  depends_on 'python3' => :build
  depends_on 'glibc' # R
end
