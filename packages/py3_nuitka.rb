require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.1.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '622dd60105b5b641731e38927465b347000a531efd919108ae5631a1f73932d6',
     armv7l: '622dd60105b5b641731e38927465b347000a531efd919108ae5631a1f73932d6',
       i686: 'bc3aa7dfcc512efdd47420b344f1de9ce94dfecaa35342b60431999d7751d295',
     x86_64: '3b3bdc57c9671cf87e3dc1a17918bc3d5d4d8832006f6b3dc9eee89230ce6dd7'
  })

  depends_on 'python3' => :logical

  no_source_build
end
