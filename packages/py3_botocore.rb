require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.7-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '503f3eb5fe0cdba9d5e22bda5d33cce51ae1381786234db91177da8f2f73cf00',
     armv7l: '503f3eb5fe0cdba9d5e22bda5d33cce51ae1381786234db91177da8f2f73cf00',
       i686: '45b336dcc89a6930cc4f99ef5fd51e4f6f424d1ae9b3fa66c20057cf1835cd50',
     x86_64: '91218148b8cc2158ceede33e4530bdf36d912ffbec48c540b8300c564db2057c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
