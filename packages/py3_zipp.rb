require 'buildsystems/pip'

class Py3_zipp < Pip
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  version "3.22.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '464a84df87f0c2f34df3cf1ab39bc3e8bd8ae86840ecccec053341b571b19a23',
     armv7l: '464a84df87f0c2f34df3cf1ab39bc3e8bd8ae86840ecccec053341b571b19a23',
       i686: '06991070247fbaeb8895df9148ac71e1a98eccdeedd4474cfdf3c8235c4d01a0',
     x86_64: '72aa6bcbf7d8507b4bf525b3db40a1279806242664706e360f1022fb7bfbd16a'
  })

  depends_on 'python3' => :build

  no_source_build
end
