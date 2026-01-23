require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.33-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '874320a9d570c5c8719bda104cf80b46ad71339b6d76bda156ce9e8348f89005',
     armv7l: '874320a9d570c5c8719bda104cf80b46ad71339b6d76bda156ce9e8348f89005',
       i686: '188cf30231b1f9f87fe29ce91481d26464a6b2b1ca6d426a4bf4414bc7c8ba7f',
     x86_64: 'e1e41740c070809a19d2e5edf6cee636254ce74214efb827dd5c522b28fd6824'
  })

  depends_on 'python3' => :build

  no_source_build
end
