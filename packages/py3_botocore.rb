require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.59-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '42376f37f744328c81b6644275c537d54047c0df0356977632f9dd5c9cdcd042',
     armv7l: '42376f37f744328c81b6644275c537d54047c0df0356977632f9dd5c9cdcd042',
       i686: 'dafa8be311a8b20bf912226e5f62e2e45abbc04043894303618e71a87aab6f6a',
     x86_64: 'edc48f79b98032c0c38b70abfab62a5c7c3417afe1dc58a505b4c6ab1ab8f5a5'
  })

  depends_on 'python3' => :logical

  no_source_build
end
