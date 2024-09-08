require 'buildsystems/pip'

class Py3_decorator < Pip
  description 'define signature-preserving function decorators and decorator factories'
  homepage 'https://github.com/micheles/decorator/'
  version "#{@_ver}-py3.12"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
