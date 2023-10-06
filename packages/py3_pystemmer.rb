require 'buildsystems/pip'

class Py3_pystemmer < Pip
  description 'Snowball stemming algorithms, for information retrieval'
  homepage 'http://snowball.tartarus.org'
  @_ver = '2.0.1'
  version "#{@_ver}-py3.12"
  license 'BSD MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build
  no_compile_needed
  depends_on 'glibc' # R
end
