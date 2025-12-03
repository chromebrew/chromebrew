require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.8.9-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c97b5c027491fd6353609c50d7fa663035c5c08a212bfab12389cb7abe0c8ea6',
     armv7l: 'c97b5c027491fd6353609c50d7fa663035c5c08a212bfab12389cb7abe0c8ea6',
       i686: '1044c34c98c57c70bea5e849f80315ea723a2eb4d809da8cc0123613e686acf1',
     x86_64: 'e8a763b42193b0ceaed7065a10be956d48657b88597141179ab5a59d3871f0cc'
  })

  depends_on 'python3' => :build

  no_source_build
end
