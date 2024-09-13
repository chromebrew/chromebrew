require 'buildsystems/pip'

class Py3_zipp < Pip
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  version '3.20.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df69e9c1a655f8e24bca7357ee2e17d51e0c9fb2fdd285f786f2e65a033281bc',
     armv7l: 'df69e9c1a655f8e24bca7357ee2e17d51e0c9fb2fdd285f786f2e65a033281bc',
       i686: '587bc59750542770282d2b873e3bedbf8b59700e410486dd304bdb3d35b0fac0',
     x86_64: 'ce4202d8306b56bb29f762b5a7dc427db11407617386915e25026f620a873c2c'
  })

  depends_on 'python3' => :build

  no_source_build
end
