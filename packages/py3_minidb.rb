require 'buildsystems/pip'

class Py3_minidb < Pip
  description 'Minidb is a simple SQLite3-based store for Python objects.'
  homepage 'https://thp.io/2010/minidb/'
  version "#{@_ver}-py3.12"
  license 'ISC'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
