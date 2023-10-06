require 'buildsystems/pip'

class Py3_minidb < Pip
  description 'Minidb is a simple SQLite3-based store for Python objects.'
  homepage 'http://thp.io/2010/minidb/'
  @_ver = '2.0.5'
  version "#{@_ver}-py3.12"
  license 'ISC'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build
  no_compile_needed
end
