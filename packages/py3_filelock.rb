require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'de32856da3f1197bd8a0e92c88e043a45b5bd8cb78a6180e0d8c1a8ccbb6f72c',
     armv7l: 'de32856da3f1197bd8a0e92c88e043a45b5bd8cb78a6180e0d8c1a8ccbb6f72c',
       i686: '77c1e65e1d9171e9fe101fe72885efe7eb0058f65648f7e8851e5fd11072b8ee',
     x86_64: '39c07af44a7cf9cdab8d62d37fcce6d30a6be44f80449881d0bc38d7f0844763'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
