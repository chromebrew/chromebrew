require 'buildsystems/pip'

class Py3_zipp < Pip
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  version "4.1.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd0e3c32ab13826588b26e609f3f797cdbcf80e10a9924046497f72f8b5d1857',
     armv7l: 'dd0e3c32ab13826588b26e609f3f797cdbcf80e10a9924046497f72f8b5d1857',
       i686: '672a4833f8dd9b29a3bd463099d212e1a6faf02413f5fbe445852910a4e0ab30',
     x86_64: '92e7fabfea840a788c5c49b2303451f745ca8e9b3875f21eb9bb4e0dc49dabbb'
  })

  depends_on 'python3' => :logical

  no_source_build
end
