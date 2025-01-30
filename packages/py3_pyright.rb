require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.393-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b14e1ea89a48e9e255522b532991a94300aab56ed036f560dba36b6fb7583a6',
     armv7l: '6b14e1ea89a48e9e255522b532991a94300aab56ed036f560dba36b6fb7583a6',
       i686: '5936190b2aa532fedd6882e99a865a838648de2152790aff33e455b8d33533e9',
     x86_64: '3074e3cdf4571e8a8ab8fc81805cc29fd4cf647a282bd23eec1626f9c9bd3690'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
