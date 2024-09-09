require 'buildsystems/pip'

class Py3_pyxdg < Pip
  description 'PyXDG contains implementations of freedesktop.org standards in python.'
  homepage 'https://freedesktop.org/wiki/Software/pyxdg/'
  version '0.28-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_source_build
end
