require 'buildsystems/pip'

class Py3_sortedcontainers < Pip
  description 'Python Sorted Container Types: Sorted List, Sorted Dict, and Sorted Set'
  homepage 'http://www.grantjenks.com/docs/sortedcontainers/'
  @_ver = '2.4.0'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build
  no_compile_needed
end
