require 'buildsystems/python'

class Py3_wcwidth < Python
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version '0.2.13-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jquast/wcwidth.git'
  version '0.2.13-py3.12'
  binary_compression 'tar.zst'


  depends_on 'python3' => :build
end
