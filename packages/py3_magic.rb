require 'buildsystems/setup_py/v1'

class Py3_magic < Setup_py_v1
  description 'Magic is a python wrapper for libmagic.'
  homepage 'https://github.com/ahupp/python-magic/'
  @_ver = '0.4.22'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ahupp/python-magic.git'
  git_hashtag @_ver

  depends_on 'filecmd'
  depends_on 'py3_setuptools' => :build
end
