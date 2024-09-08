require 'buildsystems/python'

class Py3_wheel < Python
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  version '0.44.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/wheel.git'
  version '0.44.0-py3.12'
  binary_compression 'tar.zst'


  depends_on 'python3'
  depends_on 'py3_packaging'
end
