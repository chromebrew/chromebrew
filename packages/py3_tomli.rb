require 'buildsystems/pip'

class Py3_tomli < Pip
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  version "2.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1149c819f58e6292756159fa9043e8bdbdecf885306d134a46a6f45c9e2184ae',
     armv7l: '1149c819f58e6292756159fa9043e8bdbdecf885306d134a46a6f45c9e2184ae',
       i686: 'dba6016c27fd8e5caa136f13fd138d5d648cbe06b45215f24850198432b5a190',
     x86_64: '0fc5af5bab2569c0b9b5c65ae33378198dbf636d0ab40f90d62b3efc538a0b8f'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  no_source_build
end
