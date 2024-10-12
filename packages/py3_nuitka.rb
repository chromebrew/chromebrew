require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.4.8-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f2f3983c42ac748ca776b1bcfdd1fb831c4d964b91607965d00d8e18d9d47b84',
     armv7l: 'f2f3983c42ac748ca776b1bcfdd1fb831c4d964b91607965d00d8e18d9d47b84',
       i686: 'e3074c9ad806a7518ece23f823598f672d2b14c5337ca0aefcd19b7af682eeb5',
     x86_64: '24c8f7b29efacfc3354cd3b879751becda6e9935e6e5ac2411e3cdc1d6be2c2d'
  })

  depends_on 'python3' => :build

  no_source_build
end
