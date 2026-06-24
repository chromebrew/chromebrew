require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.36-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df0e1e15cc7a085877b0ce586d7101eecd071ab2fbd29c90d0600690e39d4415',
     armv7l: 'df0e1e15cc7a085877b0ce586d7101eecd071ab2fbd29c90d0600690e39d4415',
       i686: '605f324d433f6358694fdfcd016574fbd680f590b3add5de5c99670c20f22286',
     x86_64: '72ba0522e86d36652157a2ecb8c138cbd536903ead23abc49293fb2a07665315'
  })

  depends_on 'python3' => :logical

  no_source_build
end
