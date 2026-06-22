require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.1.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1806e48b6f73ffc179c100c3001d3ba47553365f05ddd5450c3307ff2c24afef',
     armv7l: '1806e48b6f73ffc179c100c3001d3ba47553365f05ddd5450c3307ff2c24afef',
       i686: 'f26fccc907ade2a937a076f96bd9c564007da65309f7465e6474513c4bf01f7f',
     x86_64: '95a2f6d07f68e31e918466c3738482d12d83c505909a8e37af8ebf8a253a4bd7'
  })

  depends_on 'python3' => :logical

  no_source_build
end
