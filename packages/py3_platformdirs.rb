require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.11.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '864f155c268091820cef6c2109a423ed39f72f81b0c4a988846456f3c9fb920d',
     armv7l: '864f155c268091820cef6c2109a423ed39f72f81b0c4a988846456f3c9fb920d',
       i686: '48870ab482094656bbdcd30ee1dca5e66c2f8ac126db70214b9abf3f99109df6',
     x86_64: '48870ab482094656bbdcd30ee1dca5e66c2f8ac126db70214b9abf3f99109df6'
  })

  depends_on 'python3' => :logical

  no_source_build
end
