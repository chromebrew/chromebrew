require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  @_ver = '2.0.1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build

  no_compile_needed
end
