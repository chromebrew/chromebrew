require 'buildsystems/pip'

class Py3_pyudev < Pip
  description 'Pyudev provides Python bindings for udev.'
  homepage 'https://pyudev.readthedocs.io/'
  version '0.22-py3.12'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_compile_needed
end
