require 'buildsystems/python'

class Py3_six < Python
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://six.readthedocs.io/'
  version '1.16.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/benjaminp/six.git'
  version '1.16.0-py3.12'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build
end
