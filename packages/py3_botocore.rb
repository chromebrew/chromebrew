require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.45-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c85fbdf551f9914d960037c113b32502364fab3eb3ab24be62fb2beed4f66529',
     armv7l: 'c85fbdf551f9914d960037c113b32502364fab3eb3ab24be62fb2beed4f66529',
       i686: 'ba25ac6c68a62ac56c9c0d1045dea20317319082b731bff50ac8f1769367382d',
     x86_64: '736325e6d7b21e2477dd740660681b34016fc2ae3acea3d818f9ce5b00c0049c'
  })

  depends_on 'python3' => :build

  no_source_build
end
