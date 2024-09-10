require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version '3.16.0-py3.12'
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b13ec85c7a81a1dc6a6eb9cad950119eec7e47c6140253291824e61e125e790a',
     armv7l: 'b13ec85c7a81a1dc6a6eb9cad950119eec7e47c6140253291824e61e125e790a',
       i686: 'f62cc2a13efcd16d7f136651486ff93c82cb6d0b2920367e0e83123932f5091c',
     x86_64: 'dd6d24baa9d6a334c9fdaa2274077a5ff9210b4d5f716caf24b9fdee935f65b0'
  })

  depends_on 'python3' => :build

  no_source_build
end
