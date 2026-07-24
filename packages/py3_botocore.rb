require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.55-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d8fe61a17ad0f528c6f3b68e9a30ae50f015bb85f019c8b2829ec4b672882bf',
     armv7l: '3d8fe61a17ad0f528c6f3b68e9a30ae50f015bb85f019c8b2829ec4b672882bf',
       i686: '36fa1f43f8c6c4ace754c6a6f110dac3dfc5f1ad1d89d834ab89ad381b44a8f3',
     x86_64: 'dbe65e2a3e2bf7e6af46433079ec069977cfbbfe27a77aec03304dfa0ff3beec'
  })

  depends_on 'python3' => :logical

  no_source_build
end
