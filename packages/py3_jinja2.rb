require 'buildsystems/pip'

class Py3_jinja2 < Pip
  description 'Jinja2 is a very fast and expressive template engine.'
  homepage 'https://jinja.palletsprojects.com/'
  version "3.1.6-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e881b05b2112a1535b77be62a7992712b90b672a5c5be6be5444ac6b0d079ac',
     armv7l: '2e881b05b2112a1535b77be62a7992712b90b672a5c5be6be5444ac6b0d079ac',
       i686: 'cb82661f033e6712caa0c3809bf2cf422e0a34097cd5b3edcc31c8e3b549a4a2',
     x86_64: '2248ef812d43be90339a5fe82479b942107853a8b2764777b54ee6e792a30f46'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :build

  no_source_build
end
