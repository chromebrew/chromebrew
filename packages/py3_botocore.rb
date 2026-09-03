require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.87-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '418dbce389e376ba2c8feba4106d59de1093f21392b6d46c53f720d42d4eecac',
     armv7l: '418dbce389e376ba2c8feba4106d59de1093f21392b6d46c53f720d42d4eecac',
       i686: '8a8cd518e1a53c950e511c0e7ed23d03419b7614729c9bfc4c1000087d01e85b',
     x86_64: '3847b0224786ebcd2870fdead5c0cc84d92b964dbf5a3d39102cca62e446aa89'
  })

  depends_on 'python3' => :logical

  no_source_build
end
