require 'buildsystems/pip'

class Py3_libevdev < Pip
  description 'Libevdev is a Python wrapper around the libevdev C library.'
  homepage 'https://python-libevdev.readthedocs.io/'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
