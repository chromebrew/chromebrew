require 'buildsystems/pip'

class Py3_minidb < Pip
  description 'Minidb is a simple SQLite3-based store for Python objects.'
  homepage 'https://thp.io/2010/minidb/'
  version '2.0.8-py3.12'
  license 'ISC'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_source_build
end
