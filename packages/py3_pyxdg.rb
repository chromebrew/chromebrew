require 'buildsystems/pip'

class Py3_pyxdg < Pip
  description 'PyXDG contains implementations of freedesktop.org standards in python.'
  homepage 'https://freedesktop.org/wiki/Software/pyxdg/'
  @_ver = '0.28'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build
  no_compile_needed

  no_compile_needed
end
