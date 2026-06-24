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
    aarch64: 'f448b4a5d4b7f4fec035407b3d0173ce60ae2cfe88b1e884dd8a06c35c620d0a',
     armv7l: 'f448b4a5d4b7f4fec035407b3d0173ce60ae2cfe88b1e884dd8a06c35c620d0a',
       i686: 'ea520ed34468c04fba49bd5a41d1e66ae5a14de8d63396e39f5f1a5e9e9272b5',
     x86_64: '36b184bdb19a6d435345319296a76357aff8074f9600f42ddf8de65b85699727'
  })

  depends_on 'python3' => :logical

  no_source_build
end
