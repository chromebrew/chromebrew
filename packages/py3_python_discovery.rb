require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.5.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a350ad1cbf31bbd012e98cf38d25b9c270fc92cf1dd4ee3856d21e5ba0ddd3d3',
     armv7l: 'a350ad1cbf31bbd012e98cf38d25b9c270fc92cf1dd4ee3856d21e5ba0ddd3d3',
       i686: '0294478419f336c819c6a8d3bd7296452607026652080562a558a5beffa7abb0',
     x86_64: 'bf5d7b9c103f4b59461b613c16f626db5686b6e887ce738590edf5c24fb583f4'
  })

  depends_on 'python3' => :logical

  no_source_build
end
