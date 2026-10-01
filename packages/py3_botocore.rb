require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.106-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '445375dd3b3b6333ad840563917358580c681ec69a02859e9891dff8a49ce588',
     armv7l: '445375dd3b3b6333ad840563917358580c681ec69a02859e9891dff8a49ce588',
       i686: '59e5a83946b7b4d61e6d75aaaf6c957f014a7b78836c43417ac94dbd06c5a3ee',
     x86_64: '56adb09e16769c76d0662454b0cd3fd276dbcf94aec832f7ee9e2b183dd22569'
  })

  depends_on 'python3' => :logical

  no_source_build
end
