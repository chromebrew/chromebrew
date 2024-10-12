require 'buildsystems/pip'

class Py3_python_magic < Pip
  description 'Magic is a python wrapper for libmagic.'
  homepage 'https://github.com/ahupp/python-magic/'
  version "0.4.27-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a214a81f34130f350bae28fd83dce092b8de9c95785022c7d8735ef1b0566fe',
     armv7l: '2a214a81f34130f350bae28fd83dce092b8de9c95785022c7d8735ef1b0566fe',
       i686: 'b168fc8ba04d29be58900c285c34c007f4324eb234090db44a2868643b645339',
     x86_64: '40fb8e9912aaee7c06a0c797fb3182641256742c1eb1847403e77aef7c3844ec'
  })

  depends_on 'filecmd'
  depends_on 'python3' => :build

  no_source_build
end
