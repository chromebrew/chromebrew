require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.0.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c829f4dc52779293acd942fa574acdc0eb6b377c14b23a60c53405126c9a5a6c',
     armv7l: 'c829f4dc52779293acd942fa574acdc0eb6b377c14b23a60c53405126c9a5a6c',
       i686: 'f9af04199d07ec9421516c8846134ed5401219f2a0f7619942aad0b335c21de0',
     x86_64: '3a3907e2987c707c9e1a4ad856b9e58ca3c1e230d2cc2e8b7974cb115cdc1fd7'
  })

  depends_on 'python3' => :build

  no_source_build
end
