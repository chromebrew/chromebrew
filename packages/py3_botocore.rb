require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.25-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '75f9be11cb2dc1306b060cfcc6c948429979a5cd41e412ba4958836c0ec96d58',
     armv7l: '75f9be11cb2dc1306b060cfcc6c948429979a5cd41e412ba4958836c0ec96d58',
       i686: 'e613e051e6ad4da744277c55feab6f9ddd3993209c8ff06ae3c013f66f7ef1b0',
     x86_64: 'ca18633c7728b98fd6a6b13e9d25e78a7d2b5fbf7d07d97338fee75fce908721'
  })

  depends_on 'python3' => :build

  no_source_build
end
