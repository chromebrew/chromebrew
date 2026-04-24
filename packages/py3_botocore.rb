require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.95-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '176bb0b974cd35c97677ccacba6ad8066d637b88819964014af8ec4ab1673026',
     armv7l: '176bb0b974cd35c97677ccacba6ad8066d637b88819964014af8ec4ab1673026',
       i686: 'dbcca6c1b2a39bdecaea69df9acd03f5033f97b3cb3b1299105452be8398ff5c',
     x86_64: 'cb7380dff2b9f59bb0437a569e334f2e9b70d5569c10f0cef4f4f8b778828b05'
  })

  depends_on 'python3' => :logical

  no_source_build
end
