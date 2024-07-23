require 'buildsystems/pip'

class Py3_pygments < Pip
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  @_ver = '2.18.0'
  version "#{@_ver}-py3.12"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build
  no_compile_needed
end
