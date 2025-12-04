require 'buildsystems/pip'

class Py3_editables < Pip
  description 'A Python library for creating "editable wheels"'
  homepage 'https://editables.readthedocs.io'
  version "0.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ae8fc003159785d26744d581c3842c66f9cf2bbebc9d7b94eba059d97f6c169d',
     armv7l: 'ae8fc003159785d26744d581c3842c66f9cf2bbebc9d7b94eba059d97f6c169d',
       i686: '97c7c4f8072e3b75f5560ba7058ca91ca27858387ea5e615f7bda4c1cfda5518',
     x86_64: '46c74edf4748aae06650490dce267a896d0ee74b147a00923187710dc90c6ca3'
  })

  depends_on 'python3' => :build

  no_source_build
end
