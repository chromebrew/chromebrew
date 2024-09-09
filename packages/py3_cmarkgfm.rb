require 'buildsystems/pip'

class Py3_cmarkgfm < Pip
  description 'Python bindings to GitHub\'s cmark.'
  homepage 'https://github.com/theacodes/cmarkgfm'
  version '2024.1.14-py3.12'
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'python3' => :build

  no_source_build
end
