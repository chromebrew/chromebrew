require 'buildsystems/pip'

class Py3_future < Pip
  description 'Future provides clean single-source support for Python 3 and 2.'
  homepage 'https://python-future.org/'
  version '1.0.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_source_build
end
