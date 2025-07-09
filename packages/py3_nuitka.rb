require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.7.12-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '01de3ca67ee90d8bc12d148aa7d940c23cdaef5173d526c153ab3f91b1771ba4',
     armv7l: '01de3ca67ee90d8bc12d148aa7d940c23cdaef5173d526c153ab3f91b1771ba4',
       i686: 'f65dcc4e5f90166c41bbff973556d3e5ba54f69d3f5a401b7b024c65ef1ee59c',
     x86_64: 'a0836175c5be0658173197eb0d784b064a6d1d3d6af3fa157549cedde8308f04'
  })

  depends_on 'python3' => :build

  no_source_build
end
