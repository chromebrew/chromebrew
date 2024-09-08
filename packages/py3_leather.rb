require 'buildsystems/pip'

class Py3_leather < Pip
  description 'Leather is a fast, approximate chart generator in Python.'
  homepage 'https://leather.readthedocs.io/'
  version '0.4.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'py3_six'
  depends_on 'python3' => :build
end
