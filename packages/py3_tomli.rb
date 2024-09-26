require 'buildsystems/pip'

class Py3_tomli < Pip
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  version "2.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b500c56d8fd105826c84d9175af7650a74139fa052f5e04ba92d9df2964c43d1',
     armv7l: 'b500c56d8fd105826c84d9175af7650a74139fa052f5e04ba92d9df2964c43d1',
       i686: '2d17475fb300405cfadfd507ca0d71bb7daac7f414e9211b2d8acd12ec622ec0',
     x86_64: '26a9f5cc2cbcabf0699b404f601d3fc1c652e32312321c1d832df5d991590e71'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  no_source_build
end
