require 'buildsystems/pip'

class Py3_sortedcontainers < Pip
  description 'Python Sorted Container Types: Sorted List, Sorted Dict, and Sorted Set'
  homepage 'http://www.grantjenks.com/docs/sortedcontainers/'
  version '2.4.0-py3.12'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build

  no_compile_needed
end
