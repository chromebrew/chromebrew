require 'buildsystems/pip'

class Py3_six < Pip
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://six.readthedocs.io/'
  version "1.16.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9485325de6a480c62cbd38f958fecc34e372c7f7978a13b33fc9be32fd53bc92',
     armv7l: '9485325de6a480c62cbd38f958fecc34e372c7f7978a13b33fc9be32fd53bc92',
       i686: '3baf6840d39b7ec7145730e5f2c23ce90f4afd01de1d1a5641bb6df0d9a745e7',
     x86_64: '05c0c858e44081974eb5f39182d1a98206e42e452e2d0fd5cc74a6d95d77bd84'
  })

  depends_on 'python3' => :build

  no_source_build
end
