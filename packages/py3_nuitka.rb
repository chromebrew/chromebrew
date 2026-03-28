require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.0.7-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06486b3bd73a66a9035f6a752828ce4b8e6de8c857df6ed342de54bf8c7fadad',
     armv7l: '06486b3bd73a66a9035f6a752828ce4b8e6de8c857df6ed342de54bf8c7fadad',
       i686: '4e5093ff50e8bbc197d63fc903e3cf0e41a45524528691555aadc9e668a4dcbd',
     x86_64: 'd63f7aee1e68ecd96db7159f99c1bedadf23ee7d1d37c5751e64ae756c460518'
  })

  depends_on 'python3' => :logical

  no_source_build
end
