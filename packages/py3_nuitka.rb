require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.4-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99fad48714c3ab5b73dabaa64ce6216bd6fe4fb9310811e66cfbd72e40a25a5b',
     armv7l: '99fad48714c3ab5b73dabaa64ce6216bd6fe4fb9310811e66cfbd72e40a25a5b',
       i686: '7aa0a47e16d8bbf75dff0f8e380a33b7ec35ff12bc7cae8d19c3fa35c673c2b3',
     x86_64: 'a656239c40380a2cc4ca633d01963e406b929b456aafa4badd3441a91c717336'
  })

  depends_on 'python3' => :logical

  no_source_build
end
