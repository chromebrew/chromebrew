require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.8.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ca5a4117af3421d96f00498f34081c54233bbd5b63ccb370b2ee3fdade9ea96',
     armv7l: '5ca5a4117af3421d96f00498f34081c54233bbd5b63ccb370b2ee3fdade9ea96',
       i686: '48f1d202bc9cdb2ec67f5707c3b3a71551a7a996d6b6daf84adf15ae5a5e9bdd',
     x86_64: 'ae49cf0061545a27affebe8793db2e80a3239550d8b3d1572b4d9bade8fe001f'
  })

  depends_on 'python3' => :build

  no_source_build
end
