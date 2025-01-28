require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.6.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e0d0bd56c9f5d920248edd56c464fffc86ecb40fb373c9070c388210ad6f162',
     armv7l: '2e0d0bd56c9f5d920248edd56c464fffc86ecb40fb373c9070c388210ad6f162',
       i686: '2c9117f6bbb2c0e929762459d168c13f6cbff09ac1fd69b331f8ac63f1bdf73a',
     x86_64: '88500df6360563fff18b545160224258d162a5dd6398dfd013aeb5fee450c30a'
  })

  depends_on 'python3' => :build

  no_source_build
end
