require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.112-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a8066c647095a3d13b11ba841264ee9086b8bb2185de219a4df272167b5f3fe',
     armv7l: '5a8066c647095a3d13b11ba841264ee9086b8bb2185de219a4df272167b5f3fe',
       i686: '142ba55e65a783540b674781b9f7b0d3538bb4f4a8ae4b044b8d10f6014720f6',
     x86_64: 'b27a65254efbfe824bbc42c0ebbc4553716b1113f4b916193d5f60bd043dddf1'
  })

  depends_on 'python3' => :logical

  no_source_build
end
