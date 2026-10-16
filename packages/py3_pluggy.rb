require 'buildsystems/pip'

class Py3_pluggy < Pip
  description 'Pluggy provides plugin and hook calling mechanisms for Python.'
  homepage 'https://pluggy.readthedocs.io/'
  version "1.7.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '43b7654cc98fef20ab0eb4f545d8d752820d831f726da8bce86efd6d25e6aecb',
     armv7l: '43b7654cc98fef20ab0eb4f545d8d752820d831f726da8bce86efd6d25e6aecb',
       i686: 'f77cd49698f7f0c963c95f1947994873df78f1330d7e5a1eea28d47fccdad85d',
     x86_64: '5ec49d7cf37568f457b48cb75f9803cec89f994d71ba8d4651fe53504e448c48'
  })

  depends_on 'python3' => :logical

  no_source_build
end
