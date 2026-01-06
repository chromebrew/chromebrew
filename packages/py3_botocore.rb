require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.22-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa51d87df4e07fb31a2b75fde41801aad9f99283388a6d20d58c88270ef49fac',
     armv7l: 'fa51d87df4e07fb31a2b75fde41801aad9f99283388a6d20d58c88270ef49fac',
       i686: '65fcc228db2065892168f5c8bc043760976f1989260b927931c1ac61126c3724',
     x86_64: 'cd8971de6d9ee6f20ba27f435863cbdd890b788108593bf74bff48309c4ba34c'
  })

  depends_on 'python3' => :build

  no_source_build
end
