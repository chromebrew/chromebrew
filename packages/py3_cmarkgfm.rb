require 'buildsystems/pip'

class Py3_cmarkgfm < Pip
  description 'Python bindings to GitHub\'s cmark.'
  homepage 'https://github.com/theacodes/cmarkgfm'
  @_ver = '2022.10.27'
  version "#{@_ver}-py3.12"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'python3' => :build

  no_compile_needed
end
