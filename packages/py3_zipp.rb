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
       i686: '3bece534a32b4e7215740bf49e3f5874344d5c7bf8892ab689c5b09fe83dafc6',
     x86_64: '72aa6bcbf7d8507b4bf525b3db40a1279806242664706e360f1022fb7bfbd16a'
  })

  depends_on 'python3' => :build

  no_source_build
end
